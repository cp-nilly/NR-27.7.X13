package kabam.lib.net.impl {
import com.company.assembleegameclient.parameters.Parameters;
import com.hurlant.crypto.symmetric.ICipher;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.events.TimerEvent;
import flash.net.Socket;
import flash.utils.ByteArray;
import flash.utils.Timer;

import kabam.lib.net.api.MessageProvider;

import org.osflash.signals.Signal;

public class SocketServer {

    public static const MESSAGE_LENGTH_SIZE_IN_BYTES:int = 4;

    public const connected:Signal = new Signal();
    public const closed:Signal = new Signal();
    public const error:Signal = new Signal(String);
    private const unsentPlaceholder:Message = new Message(0);
    private const data:ByteArray = new ByteArray();

    [Inject]
    public var messages:MessageProvider;
    [Inject]
    public var socket:Socket;
    [Inject]
    public var socketServerModel:SocketServerModel;
    public var delayTimer:Timer;
    private var head:Message;
    private var tail:Message;
    private var messageLen:int = -1;
    private var outgoingCipher:ICipher;
    private var incomingCipher:ICipher;
    private var server:String;
    private var port:int;

    public function SocketServer() {
        this.head = this.unsentPlaceholder;
        this.tail = this.unsentPlaceholder;
        super();
    }

    public function setOutgoingCipher(_arg1:ICipher):SocketServer {
        this.outgoingCipher = _arg1;
        return (this);
    }

    public function setIncomingCipher(_arg1:ICipher):SocketServer {
        this.incomingCipher = _arg1;
        return (this);
    }

    public function connect(_arg1:String, _arg2:int):void {
        this.server = _arg1;
        this.port = _arg2;
        this.addListeners();
        this.messageLen = -1;
        if (this.socketServerModel.connectDelayMS) {
            this.connectWithDelay();
        }
        else {
            this.socket.connect(_arg1, _arg2);
        }
    }

    private function addListeners():void {
        this.socket.addEventListener(Event.CONNECT, this.onConnect);
        this.socket.addEventListener(Event.CLOSE, this.onClose);
        this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
        this.socket.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
        this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
    }

    private function connectWithDelay():void {
        this.delayTimer = new Timer(this.socketServerModel.connectDelayMS, 1);
        this.delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
        this.delayTimer.start();
    }

    private function onTimerComplete(_arg1:TimerEvent):void {
        this.delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
        this.socket.connect(this.server, this.port);
    }

    public function disconnect():void {
        this.socket.close();
        this.removeListeners();
        this.closed.dispatch();
    }

    private function removeListeners():void {
        this.socket.removeEventListener(Event.CONNECT, this.onConnect);
        this.socket.removeEventListener(Event.CLOSE, this.onClose);
        this.socket.removeEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
        this.socket.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
        this.socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
    }

    public function sendMessage(_arg1:Message):void {
        this.tail.next = _arg1;
        this.tail = _arg1;
        ((this.socket.connected) && (this.sendPendingMessages()));
    }

    private function sendPendingMessages():void {
        var _local1:Message = this.head.next;
        var _local2:Message = _local1;
        while (_local2) {
            this.data.clear();
            _local2.writeToOutput(this.data);
            this.data.position = 0;
            if (this.outgoingCipher != null) {
                this.outgoingCipher.encrypt(this.data);
                this.data.position = 0;
            }
            this.socket.writeInt((this.data.bytesAvailable + 5));
            this.socket.writeByte(_local2.id);
            this.socket.writeBytes(this.data);
            _local2.consume();
            _local2 = _local2.next;
        }
        this.socket.flush();
        this.unsentPlaceholder.next = null;
        this.unsentPlaceholder.prev = null;
        this.head = (this.tail = this.unsentPlaceholder);
    }

    private function onConnect(_arg1:Event):void {
        this.sendPendingMessages();
        this.connected.dispatch();
    }

    private function onClose(_arg1:Event):void {
        this.closed.dispatch();
    }

    private function onIOError(_arg1:IOErrorEvent):void {
        var _local2:String = this.parseString("Socket-Server IO Error: {0}", [_arg1.text]);
        this.error.dispatch(_local2);
        this.closed.dispatch();
    }

    private function onSecurityError(_arg1:SecurityErrorEvent):void {
        var _local2:String = this.parseString((("Socket-Server Security: {0}. Please open port " + Parameters.PORT) + " in your firewall and/or router settings and try again"), [_arg1.text]);
        this.error.dispatch(_local2);
        this.closed.dispatch();
    }

    private function onSocketData(_:ProgressEvent = null):void {
        var messageId:uint;
        var message:Message;
        var data:ByteArray;
        var errorMessage:String;
        while (true) {
            if ((((this.socket == null)) || (!(this.socket.connected)))) break;
            if (this.messageLen == -1) {
                if (this.socket.bytesAvailable < 4) break;
                try {
                    this.messageLen = this.socket.readInt();
                }
                catch (e:Error) {
                    errorMessage = parseString("Socket-Server Data Error: {0}: {1}", [e.name, e.message]);
                    error.dispatch(errorMessage);
                    messageLen = -1;
                    return;
                }
            }
            if (this.socket.bytesAvailable < (this.messageLen - MESSAGE_LENGTH_SIZE_IN_BYTES)) break;
            messageId = this.socket.readUnsignedByte();
            message = this.messages.require(messageId);
            data = new ByteArray();
            if ((this.messageLen - 5) > 0) {
                this.socket.readBytes(data, 0, (this.messageLen - 5));
            }
            data.position = 0;
            if (this.incomingCipher != null) {
                this.incomingCipher.decrypt(data);
                data.position = 0;
            }
            this.messageLen = -1;
            if (message == null) {
                this.logErrorAndClose("Socket-Server Protocol Error: Unknown message");
                return;
            }
            try {
                message.parseFromInput(data);
            }
            catch (error:Error) {
                logErrorAndClose("Socket-Server Protocol Error: {0}", [error.toString()]);
                return;
            }
            message.consume();
        }
    }

    private function logErrorAndClose(_arg1:String, _arg2:Array = null):void {
        this.error.dispatch(this.parseString(_arg1, _arg2));
        this.disconnect();
    }

    private function parseString(_arg1:String, _arg2:Array):String {
        var _local3:int = _arg2.length;
        var _local4:int;
        while (_local4 < _local3) {
            _arg1 = _arg1.replace((("{" + _local4) + "}"), _arg2[_local4]);
            _local4++;
        }
        return (_arg1);
    }

    public function isConnected():Boolean {
        return (this.socket.connected);
    }


}
}
