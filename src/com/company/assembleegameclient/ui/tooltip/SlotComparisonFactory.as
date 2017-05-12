package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.CloakComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.GeneralProjectileComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.GenericArmorComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.HelmetComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.OrbComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.PoisonComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.PrismComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.QuiverComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.ScepterComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.SealComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.ShieldComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.SkullComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.SlotComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.SpellComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.TomeComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.TrapComparison;

import kabam.rotmg.constants.ItemConstants;

public class SlotComparisonFactory {

    private var hash:Object;

    public function SlotComparisonFactory() {
        var _local1:GeneralProjectileComparison = new GeneralProjectileComparison();
        var _local2:GenericArmorComparison = new GenericArmorComparison();
        this.hash = {};
        this.hash[ItemConstants.SWORD_TYPE] = _local1;
        this.hash[ItemConstants.DAGGER_TYPE] = _local1;
        this.hash[ItemConstants.BOW_TYPE] = _local1;
        this.hash[ItemConstants.TOME_TYPE] = new TomeComparison();
        this.hash[ItemConstants.SHIELD_TYPE] = new ShieldComparison();
        this.hash[ItemConstants.LEATHER_TYPE] = _local2;
        this.hash[ItemConstants.PLATE_TYPE] = _local2;
        this.hash[ItemConstants.WAND_TYPE] = _local1;
        this.hash[ItemConstants.SPELL_TYPE] = new SpellComparison();
        this.hash[ItemConstants.SEAL_TYPE] = new SealComparison();
        this.hash[ItemConstants.CLOAK_TYPE] = new CloakComparison();
        this.hash[ItemConstants.ROBE_TYPE] = _local2;
        this.hash[ItemConstants.QUIVER_TYPE] = new QuiverComparison();
        this.hash[ItemConstants.HELM_TYPE] = new HelmetComparison();
        this.hash[ItemConstants.STAFF_TYPE] = _local1;
        this.hash[ItemConstants.POISON_TYPE] = new PoisonComparison();
        this.hash[ItemConstants.SKULL_TYPE] = new SkullComparison();
        this.hash[ItemConstants.TRAP_TYPE] = new TrapComparison();
        this.hash[ItemConstants.ORB_TYPE] = new OrbComparison();
        this.hash[ItemConstants.PRISM_TYPE] = new PrismComparison();
        this.hash[ItemConstants.SCEPTER_TYPE] = new ScepterComparison();
        this.hash[ItemConstants.KATANA_TYPE] = _local1;
        this.hash[ItemConstants.SHURIKEN_TYPE] = _local1;
    }

    public function getComparisonResults(_arg1:XML, _arg2:XML):SlotComparisonResult {
        var _local3:int = int(_arg1.SlotType);
        var _local4:SlotComparison = this.hash[_local3];
        var _local5:SlotComparisonResult = new SlotComparisonResult();
        if (_local4 != null) {
            _local4.compare(_arg1, _arg2);
            _local5.lineBuilder = _local4.comparisonStringBuilder;
            _local5.processedTags = _local4.processedTags;
        }
        return (_local5);
    }


}
}
