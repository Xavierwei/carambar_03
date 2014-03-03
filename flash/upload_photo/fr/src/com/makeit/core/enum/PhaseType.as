package com.makeit.core.enum
{

    public class PhaseType extends Object
    {
        public var name:String;
        public var step:int;
        public static const SourcePhase:PhaseType = new PhaseType("rm_source_phase", 0);
        public static const BasePhase:PhaseType = new PhaseType("rm_base_phase", 1);
        public static const OverlayPhase:PhaseType = new PhaseType("rm_lighting_phase", 2);
        public static const BorderPhase:PhaseType = new PhaseType("rm_border_phase", 3);
        public static const FinalPhase:PhaseType = new PhaseType("rm_final_phase", 4);

        public function PhaseType(param1:String, param2:int)
        {
            this.name = param1;
            this.step = param2;
            return;
        }// end function

        public function Next() : PhaseType
        {
            var _loc_1:PhaseType = null;
            if (SourcePhase == this)
            {
                _loc_1 = BasePhase;
            }
            else if (BasePhase == this)
            {
                _loc_1 = OverlayPhase;
            }
            else if (OverlayPhase == this)
            {
                _loc_1 = BorderPhase;
            }
            else
            {
                _loc_1 = FinalPhase;
            }
            return _loc_1;
        }// end function

        public function Previous() : PhaseType
        {
            var _loc_1:PhaseType = null;
            if (FinalPhase == this)
            {
                _loc_1 = BorderPhase;
            }
            else if (BorderPhase == this)
            {
                _loc_1 = OverlayPhase;
            }
            else if (OverlayPhase == this)
            {
                _loc_1 = BasePhase;
            }
            else
            {
                _loc_1 = SourcePhase;
            }
            return _loc_1;
        }// end function

    }
}
