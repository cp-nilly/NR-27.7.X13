package com.company.util {
import flash.external.ExternalInterface;
import flash.xml.XMLDocument;
import flash.xml.XMLNode;
import flash.xml.XMLNodeType;

public class HTMLUtil {


    public static function unescape(_arg1:String):String {
        return (new XMLDocument(_arg1).firstChild.nodeValue);
    }

    public static function escape(_arg1:String):String {
        return (XML(new XMLNode(XMLNodeType.TEXT_NODE, _arg1)).toXMLString());
    }

    public static function refreshPageNoParams():void {
        var _local1:String;
        var _local2:Array;
        var _local3:String;
        if (ExternalInterface.available) {
            _local1 = ExternalInterface.call("window.location.toString");
            _local2 = _local1.split("?");
            if (_local2.length > 0) {
                _local3 = _local2[0];
                if (_local3.indexOf("www.kabam") != -1) {
                    _local3 = "http://www.realmofthemadgod.com";
                }
                ExternalInterface.call("window.location.assign", _local3);
            }
        }
    }


}
}
