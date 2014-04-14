package ui.transformTool
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	import flash.display.BitmapData;
	internal class ArrowShapeClass extends ShapeClass
	{
		
		private const _STR_6DN:String = "12 15 0 0 0 0 0 0 7474ca00 d072aa00 ff7aab02 ff7aa808 d080ac17 6062a200 0 0 0 0 0 0 0 1100c300 e2789841 ff82a63c ff7aa228 ff85ae2e ff759b22 ff86a641 ff819b44 d0859c3c 1030df00 0 0 0 0 0 e2769034 ff90ae4a ff8ba856 ffd0edad fff1ffdc fff0ffdb ffdbf2ba ff8fa654 ff829f21 d08eac1c 0 0 0 0 7f608912 ff89a63a ff8daa3e fff4ffce ffe6f8de ff83928d ff85948f ffe8f8dd fff2ffc5 ff91b031 ff8dad28 607ab500 0 0 0 f77b982e ff8aa731 ffcae47f ffefffd2 ff1a2517 ff000300 ff000300 ff1b2817 ffedfdd6 ffd6eea0 ff819d36 d0759e11 0 0 6179cd00 ff82a620 ff8aa927 fff1ffa9 ff9da886 ff000100 ff000104 ff000202 ff000400 ff92a182 fff5ffd3 ff84a346 ff7aa21e 0 1100ff00 f07ea821 ff7da40b ff88a91e fff2ffa6 ffa4ad8e ff000007 fffefdff ff00000b ff000400 ff8e9e77 fff5ffcc ff719334 ff82ad2a 0 816fb628 ff769e24 fa7aa20e ff8aab20 ffd4eb83 fff0f8d1 ff212121 ff00000b ff000106 ff1e280f ffebfec7 ffcfed97 ff7ca137 d072a51c 0 f07da455 b06a9b1e 6a71c000 ff7e9d1b ff9fb745 fff8ffc9 ffeef2db ff94968b ff878b7a fff6ffd7 ffe5fcac ff9fc24a ff7ca32e 6058b700 6159b508 806ca932 0 0 d082a325 ff8ca339 ff99a960 ffdbe6ae fff9ffca fffcffcc ffdceea4 ff99b256 ff81a32b d0659014 0 302aba00 0 0 0 1169ff00 d07f993d ff7f9241 ff8a9e3d ff88a024 ff87a221 ff7f992b ff8fa948 d0779931 1050ff00 0 0 0 0 0 0 0 6072ad00 d088a616 ff88a809 ff85a806 d080a607 607ac500 0 0 0 ";
		private const _STR_MOVE:String = "19 19 0 0 0 0 0 0 0 b8b8b8b 15000000 b2e2e2e 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 b464646 34050505 fffcfcfc 34000000 b8b8b8b 0 0 0 0 0 0 0 0 0 0 0 0 0 b000000 340f0f0f ffffffff f9000000 ffffffff 34000000 bd1d1d1 0 0 0 0 0 0 0 0 0 0 0 b000000 342c2c2c fff1f1f1 fe000000 ff030303 fe000000 ffdcdcdc 340f0f0f b000000 0 0 0 0 0 0 0 0 0 b000000 34191919 fffbfbfb ff060606 ff000000 ff080808 ff000000 ff080808 ffededed 34000000 b000000 0 0 0 0 0 0 0 b000000 34000000 ffffffff ffefefef fff6f6f6 fff2f2f2 ff030303 fff9f9f9 fff1f1f1 fff2f2f2 ffffffff 34000000 b8b8b8b 0 0 0 0 0 b747474 34000000 ffffffff ff000000 fff4f4f4 690a0a0a 690a0a0a ff000000 690c0c0c 69000000 fff2f2f2 ff000000 fffbfbfb 340a0a0a b000000 0 0 0 b747474 34050505 ffffffff ff000000 ff010101 fff3f3f3 ffffffff ffffffff ff020202 fffcfcfc ffffffff fff1f1f1 ff050505 ff000000 ffffffff 34000000 b5d5d5d 0 0 15000000 fffcfcfc ff040404 ff040404 ff020202 ff000000 ff030303 ff000000 ff040404 ff010101 ff050505 ff000000 ff020202 ff020202 ff000000 fffbfbfb 15000000 0 0 b2e2e2e 34000000 ffffffff ff000000 ff000000 fff8f8f8 fffefefe fff9f9f9 ff0b0b0b fff7f7f7 ffffffff fff9f9f9 ff000000 ff050505 fffefefe 340a0a0a b171717 0 0 0 ba2a2a2 34000000 fff9f9f9 ff080808 fff4f4f4 69020202 69000000 ff020202 690c0c0c 69000000 fff3f3f3 ff000000 ffffffff 34000000 b000000 0 0 0 0 0 b000000 34535353 fff8f8f8 fffafafa fff4f4f4 fff4f4f4 ff000000 ffffffff fffafafa fffafafa fffcfcfc 340a0a0a b464646 0 0 0 0 0 0 0 b000000 34222222 ffffffff ff000000 ff000000 ff020202 ff000000 ff020202 fffefefe 34000000 b000000 0 0 0 0 0 0 0 0 0 b8b8b8b 34000000 ffffffff fe000000 ff000000 fe060606 fff9f9f9 34272727 b464646 0 0 0 0 0 0 0 0 0 0 0 b000000 340a0a0a ffffffff f9000000 ffffffff 34000000 b000000 0 0 0 0 0 0 0 0 0 0 0 0 0 b000000 34000000 ffffffff 34000000 b171717 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 b5d5d5d 15000000 b171717 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ";
		private const _STR_ROTATION:String = "19 16 0 0 0 0 0 bd1d1d1 15000000 b000000 0 0 0 0 0 0 0 0 0 0 0 0 b000000 36000000 ffffffff 34000000 ba2a2a2 0 0 0 0 0 0 0 0 0 0 0 21080808 ffffffff ff000000 fffefefe 340f0f0f b2e2e2e 0 0 0 0 0 0 0 0 0 b8b8b8b 41000000 ffffffff ff000000 ff000000 fffdfdfd 34141414 b2e2e2e 0 0 0 0 0 0 0 b000000 361c1c1c fff4f4f4 ffffffff ff000000 ff000000 ff0a0a0a fff1f1f1 341d1d1d b000000 0 0 0 0 0 b171717 36000000 ffffffff ff020202 ff000000 ff000000 ff010101 ff000000 ff000000 fffbfbfb 153d3d3d 0 0 0 0 b000000 36262626 fffafafa ff020202 ff060606 fff4f4f4 ff070707 ff000000 ff020202 ffffffff 3f000000 21000000 b000000 0 0 0 20101010 fffbfbfb ff080808 ff000000 fff8f8f8 ffffffff ff000000 ff020202 fffdfdfd 3f000000 41080808 fffefefe 35000000 b171717 0 0 2a000000 ffffffff ff000000 ffffffff 5d080808 fffcfcfc ff000000 fffefefe 34000000 2b2f2f2f ffffffff ff000000 ffffffff 20000000 0 0 2a000000 ffffffff ff060606 fff6f6f6 34191919 34000000 fff9f9f9 34000000 b000000 2c000000 ffffffff ff000000 fffbfbfb 2a121212 0 0 2a0c0c0c ffffffff ff000000 ffffffff 2a1e1e1e b000000 150c0c0c b171717 0 2c000000 ffffffff ff010101 ffffffff 2a000000 0 0 2a060606 ffffffff ff000000 ffffffff 3f000000 bd1d1d1 0 0 b2e2e2e 41000000 ffffffff ff050505 fff8f8f8 2a2a2a2a 0 0 20000000 fff7f7f7 ff030303 ff000000 ffffffff 3f101010 2b060606 2c000000 410c0c0c ffffffff ff000000 ff030303 fff5f5f5 20181818 0 0 b8b8b8b 34000000 ffffffff ff010101 ff050505 fffcfcfc fffefefe ffffffff fffefefe ff000000 ff0a0a0a fff7f7f7 34000000 b5d5d5d 0 0 0 b000000 34000000 ffffffff ff000000 ff000000 ff000000 ff000000 ff010101 ff010101 ffffffff 34000000 b2e2e2e 0 0 0 0 0 b8b8b8b 35000000 ffffffff fffbfbfb ffffffff ffffffff fff9f9f9 ffffffff 34000000 bb9b9b9 0 0 0 0 0 0 0 b000000 20181818 2a000000 2a121212 2a0c0c0c 2a000000 20181818 b000000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ";
		private const _STR_RESIZE0:String = "18 11 0 0 0 0 b000000 15000000 b171717 0 0 0 0 0 0 0 b8b8b8b 33000000 ffffffff 33141414 b000000 0 0 0 0 0 b000000 34050505 ffffffff f1000000 ffffffff 34050505 b000000 0 0 0 b000000 34272727 fff7f7f7 fa000000 ff000000 fa060606 fffefefe 34000000 bffffff 0 b000000 34191919 fff9f9f9 ff060606 ff000000 ff050505 ff010101 ff030303 ffffffff 34000000 b5d5d5d 20202020 fff8f8f8 ff080808 ff000000 ff000000 ff030303 ff030303 ff000000 ff000000 ffffffff 20000000 20080808 ffffffff ffffffff fffefefe fffefefe ff010101 fffafafa ffffffff ffffffff ffffffff 20000000 b464646 20000000 2a373737 49000000 ffffffff ff000000 ffffffff 48000000 2a060606 20000000 b747474 0 0 0 2a121212 ffffffff ff000000 ffffffff 29060606 0 0 0 0 0 0 2a000000 fff9f9f9 ff070707 fff5f5f5 29191919 0 0 0 b000000 20181818 2a000000 49070707 ffffffff ff000000 ffffffff 48000000 2a060606 20000000 ba2a2a2 20383838 fffbfbfb ffffffff fffcfcfc fff9f9f9 ff030303 fffafafa ffffffff fffefefe ffffffff 20000000 20000000 ffffffff ff000000 ff010101 ff000000 ff000000 ff020202 ff010101 ff000000 ffffffff 20000000 b000000 34313131 fff5f5f5 ff0a0a0a ff000000 ff030303 ff000000 ff000000 fff8f8f8 342c2c2c b000000 0 bffffff 34000000 ffffffff fa000000 ff000000 fa030303 ffffffff 34141414 b2e2e2e 0 0 0 b000000 340a0a0a ffffffff f1000000 ffffffff 34000000 b000000 0 0 0 0 0 b2e2e2e 33000000 ffffffff 33000000 b171717 0 0 0 0 0 0 0 b464646 15000000 b000000 0 0 0 0 ";
		private const _STR_RESIZE135:String = "14 14 0 0 0 0 b2e2e2e 20000000 2a060606 2a0c0c0c 2a000000 2a060606 2a000000 2a434343 20000000 b464646 0 0 0 0 15181818 fffcfcfc fffdfdfd ffffffff fffdfdfd fffefefe fffefefe ffffffff fff7f7f7 20181818 0 0 0 0 b171717 340a0a0a fffefefe ff020202 ff000000 ff000000 ff0b0b0b ff000000 ffffffff 2a000000 0 0 0 0 0 b000000 340a0a0a ffffffff ff010101 ff000000 ff000000 ff070707 fff9f9f9 2a181818 b747474 15000000 b171717 0 0 0 153d3d3d 54000000 ffffffff ff040404 ff000000 ff020202 fff8f8f8 2a2a2a2a 20000000 ffffffff 34000000 bffffff 0 b000000 34000000 ffffffff ff000000 ffffffff ff000000 ff060606 fffbfbfb 2a000000 2a000000 ffffffff ffffffff 34000000 15797979 34000000 ffffffff ff020202 fffbfbfb 54060606 fffcfcfc ff000000 ffffffff 2a000000 2a121212 ffffffff ff050505 fffefefe 541b1b1b fff8f8f8 ff000000 ffffffff 34000000 15000000 340f0f0f ffffffff ffffffff 2a060606 2a060606 fffefefe ff000000 ff030303 ffffffff ff000000 ffffffff 34000000 b2e2e2e 0 b000000 34404040 fff7f7f7 20202020 2a0c0c0c ffffffff ff000000 ff010101 ff000000 ffffffff 54030303 153d3d3d 0 0 0 b171717 15313131 b171717 2a373737 fffbfbfb ff030303 ff040404 ff000000 ff000000 fffefefe 340a0a0a b171717 0 0 0 0 0 2a000000 ffffffff ff020202 ff080808 ff000000 ff000000 ff000000 ffffffff 34000000 b464646 0 0 0 0 20000000 ffffffff fffbfbfb ffffffff fffafafa ffffffff ffffffff ffffffff ffffffff 15000000 0 0 0 0 b000000 20585858 2a000000 2a060606 2a000000 2a060606 2a000000 2a060606 20000000 b8b8b8b 0 0 0 0 ";
		private const _STR_RESIZE90:String = "11 18 0 0 0 0 b000000 20080808 20000000 b000000 0 0 b000000 20404040 20000000 b5d5d5d 0 0 0 0 0 0 0 b000000 34363636 fffafafa fffbfbfb 20202020 0 0 20303030 fff8f8f8 fffcfcfc 34191919 b000000 0 0 0 0 0 b000000 34272727 fffafafa ff090909 fff5f5f5 2a0c0c0c 0 0 2a000000 ffffffff ff000000 ffffffff 34000000 b171717 0 0 0 bffffff 34000000 ffffffff ff060606 ff000000 ffffffff 49000000 2a000000 2a0c0c0c 49000000 fffefefe ff020202 ff080808 fff8f8f8 340a0a0a b5d5d5d 0 b171717 34141414 fffefefe ff020202 ff010101 ff020202 ffffffff fffdfdfd ffffffff fffdfdfd ffffffff fffafafa ff000000 ff020202 ff000000 ffffffff 34000000 bd1d1d1 15000000 ffffffff ff000000 ff000000 ff010101 ff000000 ff010101 ff020202 ff030303 ff000000 ff000000 ff050505 ff000000 ff000000 ff050505 ff020202 fffefefe 15000000 b000000 341d1d1d fffefefe ff000000 ff000000 ff070707 fff9f9f9 fffdfdfd ffffffff ffffffff ffffffff fff4f4f4 ff040404 ff000000 ff070707 fffdfdfd 34000000 b747474 0 b000000 340a0a0a ffffffff ff060606 ff000000 ffffffff 49000000 2a000000 2a242424 49000000 ffffffff ff000000 ff000000 fff9f9f9 340f0f0f b000000 0 0 0 b8b8b8b 34000000 ffffffff ff000000 ffffffff 2a000000 0 0 2a000000 ffffffff ff000000 fffdfdfd 34191919 b000000 0 0 0 0 0 b000000 34050505 ffffffff fffbfbfb 20101010 0 0 20000000 ffffffff fffefefe 34363636 b000000 0 0 0 0 0 0 0 b000000 20000000 20303030 b171717 0 0 b5d5d5d 20000000 20000000 bd1d1d1 0 0 0 0 ";
		private const _STR_RESIZE45:String = "14 14 b2e5d00 20081800 2a243100 2a061200 2a434900 2a060c00 2a242a00 2a060600 20080800 b462e00 0 0 0 0 20203000 fff5f7e2 ffffffed fff9fae8 fffafbe9 fffcfded fff5f6e8 fffffff4 fff7f7ef 15796d31 0 0 0 0 2a0c1200 fffbfcec ff010200 ff040500 ff010200 ff010100 ff050500 fff9f9f1 340f0a00 b462e00 0 0 0 0 2a1e2400 fff5f6e4 ff010200 ff060700 ff010200 ff080800 fff5f5eb 34191900 b464600 0 0 0 0 0 2a556100 fff2f4df ff050600 ff010200 ff040500 fff8f9e9 541b1e00 150c1800 0 0 0 b2e2e00 150c0c00 b170000 2a061200 ffffffec ff010300 ff030500 ffffffed ff010200 fffeffed 340a0f00 b465d00 0 bd1d100 34050500 fffffff4 20080800 2a061200 ffffffec ff010300 fffafce7 54181e00 fff7f9e4 ff050700 fff9fae8 34141900 15182400 34050a00 fffdfeee fffafbeb 2a060c00 2a181e00 fffbfcea fffcfdeb 34050a00 150c1800 34050a00 fffdfeec ff010200 fff9faea 541b1e00 fff8f9e9 ff060700 fffafbeb 2a060c00 20303000 fff4f4e8 34363600 b171700 0 bb9b900 34050500 fff9f9ed ff010200 fffffff3 ff050600 ff010200 fffffff3 2a060c00 b2e2e00 15242400 b5d5d00 0 0 0 156d6d00 54030300 fffdfdf1 ff010100 ff010100 ff010100 fffffff3 2a1e2400 0 0 0 0 0 b171700 34050500 fff9f9ef ff020200 ff010100 ff0c0d00 ff010200 fffdfef0 2a0c1200 0 0 0 0 ba28b17 34050000 fffffff8 ff010100 ff010100 ff010100 ff030400 ff070800 fff8f9e9 2a060c00 0 0 0 0 150c0000 fffffffa fff8f8f0 fffefef4 fffffff4 fff7f7eb fffffff3 ffeaebdb ffffffef 20081000 0 0 0 0 bd1b946 20080800 2a060600 2a0c0c00 2a0c0c00 2a1e2400 2a060c00 2a060c00 20283800 b174600 ";
		private const _STR_SKEW0:String = "18 11 0 0 0 b000000 20202020 20000000 b000000 0 0 0 0 0 0 bffffff 340f0f0f fffcfcfc ffffffff 3f000000 20000000 b000000 0 0 0 b747474 34050505 ffffffff ff000000 fffbfbfb ffffffff ffffffff 20000000 0 0 b000000 34000000 ffffffff ff000000 ff060606 fffafafa ff060606 ffffffff 2a000000 0 0 20000000 ffffffff ff040404 ff000000 ff111111 fff0f0f0 ff0b0b0b fffdfdfd 2a000000 0 0 2a000000 fff8f8f8 ff030303 ffffffff ff000000 ffffffff ff000000 ffffffff 2a000000 0 0 20383838 fffafafa fffafafa ffffffff ff000000 ffffffff ff020202 ffffffff 2a000000 0 0 b747474 20000000 49000000 ffffffff ff000000 ffffffff ff000000 fffefefe 2a000000 0 0 0 0 2a373737 fff9f9f9 ff040404 fffdfdfd ff000000 fffefefe 2a000000 0 0 0 0 2a000000 ffffffff ff030303 fffbfbfb ff010101 fffcfcfc 2a121212 0 0 0 0 2a000000 ffffffff ff050505 fff9f9f9 ff040404 ffffffff 49000000 20383838 b000000 0 0 2a000000 ffffffff ff000000 ffffffff ff000000 ffffffff ffffffff ffffffff 20000000 0 0 2a0c0c0c fffdfdfd ff030303 fffefefe ff010101 fffcfcfc ff000000 ffffffff 20000000 0 0 2a000000 ffffffff ff000000 ffffffff ff000000 ff010101 ff000000 3f1c1c1c b000000 0 0 2a000000 ffffffff ff000000 ffffffff ff030303 ff000000 ffffffff 20000000 0 0 0 20000000 fffefefe fffbfbfb ffffffff ff000000 ffffffff 34000000 b5d5d5d 0 0 0 b747474 20080808 3f080808 fffafafa ffffffff 340f0f0f b000000 0 0 0 0 0 0 b000000 20484848 20000000 b000000 0 0 0";
		private const _STR_SKEW45:String = "15 16 0 0 0 b2e2e2e 20000000 20383838 b000000 0 0 0 0 0 0 0 0 0 0 b000000 20585858 3f040404 fffafafa ffffffff 34141414 b2e2e2e 0 0 0 0 0 0 0 0 b2e2e2e 34000000 ffffffff fffafafa ff000000 ff070707 fffafafa 340a0a0a b171717 0 0 0 0 0 0 0 20000000 ffffffff ff000000 ffffffff ffffffff ff030303 ff000000 ffffffff 34000000 ba2a2a2 0 0 0 0 0 0 2a1e1e1e ffffffff ff040404 ff000000 ffffffff fffefefe ff040404 ff000000 fffdfdfd 34000000 b2e2e2e 0 0 0 0 0 2a000000 ffffffff ff000000 ff070707 ff000000 fffbfbfb ffffffff ff000000 ff000000 ffffffff 34000000 b8b8b8b b000000 20202020 20000000 b171717 2a0c0c0c fff9f9f9 ff0a0a0a fff6f6f6 ff000000 ff020202 fffefefe ffffffff ff020202 ff000000 ffffffff 3f000000 3f202020 ffffffff ffffffff 20000000 20000000 ffffffff ff000000 ffffffff fff4f4f4 ff060606 ff000000 ffffffff ffffffff ff000000 ff000000 ffffffff fffcfcfc ff000000 fffcfcfc 2a181818 b5d5d5d 34000000 ffffffff 3f000000 3f202020 fffdfdfd ff000000 ff040404 ffffffff fff4f4f4 ff080808 ff000000 ffffffff ff000000 fffdfdfd 2a181818 0 b000000 15242424 b000000 be8e8e8 34000000 ffffffff ff010101 ff000000 ffffffff fff8f8f8 ff000000 ff060606 ff040404 fff7f7f7 2a2a2a2a 0 0 0 0 0 b000000 340f0f0f fffefefe ff050505 ff000000 ffffffff fff7f7f7 ff010101 ff090909 fffdfdfd 2a000000 0 0 0 0 0 0 b000000 34191919 fffcfcfc ff000000 ff040404 fff8f8f8 ffffffff ff000000 ffffffff 20000000 0 0 0 0 0 0 0 b2e2e2e 34000000 ffffffff ff000000 ff040404 fffcfcfc fffcfcfc 34141414 b000000 0 0 0 0 0 0 0 0 b000000 341d1d1d fff9f9f9 fffafafa 3f101010 20000000 b2e2e2e 0 0 0 0 0 0 0 0 0 0 b171717 20000000 20101010 b000000 0 0 0 ";
		private const _STR_SKEW90:String = "11 18 0 0 0 0 0 0 0 0 0 0 b171717 20000000 20000000 b747474 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20202020 fffafafa ffffffff 41000000 21000000 b000000 0 0 0 b2e2e2e 21000000 2c171717 2c000000 2c000000 2c060606 2c000000 2c000000 2b000000 49000000 ffffffff ff0a0a0a ff000000 ffffffff 36000000 b000000 0 0 20080808 ffffffff fff6f6f6 ffffffff fffbfbfb ffffffff fffafafa fffafafa ffffffff ffffffff fffefefe ffffffff ff000000 ff000000 ffffffff 36090909 b000000 b2e2e2e 40000000 fff9f9f9 ff060606 ff000000 ff0b0b0b ff010101 ff000000 ff010101 ff000000 ff030303 ff000000 ff000000 ff000000 ff000000 ff010101 ffffffff 20080808 20181818 fff9f9f9 ffffffff ffffffff ffffffff fffcfcfc ffffffff ffffffff fffafafa ffffffff fff9f9f9 ffffffff fff8f8f8 ffffffff fffcfcfc ffffffff fffefefe 20000000 20000000 fff6f6f6 ff000000 ff070707 ff030303 ff000000 ff000000 ff000000 ff030303 ff000000 ff0d0d0d ff000000 ff060606 ff000000 ff010101 ffffffff 3f000000 b000000 b2e2e2e 34000000 fff7f7f7 ff010101 ff030303 fffefefe ffffffff fffbfbfb fffafafa fffefefe ffffffff fff7f7f7 ffffffff fffafafa ffffffff fffdfdfd 21080808 0 0 bb9b9b9 34000000 ffffffff ff000000 ff050505 fff6f6f6 490a0a0a 2a000000 2a000000 2a000000 2a000000 2a000000 2a000000 2a000000 20000000 b000000 0 0 0 b5d5d5d 34050505 fffcfcfc fffcfcfc ffffffff 21000000 0 0 0 0 0 0 0 0 0 0 0 0 0 b2e2e2e 20000000 2a373737 20000000 b171717 0 0 0 0 0 0 0 0 0 0 ";
		private const _STR_SKEW135:String = "16 15 0 0 0 0 0 0 b747474 20000000 2a181818 2a0c0c0c 2a000000 20000000 bffffff 0 0 0 0 0 0 0 b000000 35050505 ffffffff ffffffff ffffffff fffefefe fffdfdfd 34000000 b464646 0 0 0 0 0 0 17000000 ffffffff ff000000 ff060606 ff000000 ff0c0c0c ff000000 ffffffff 20000000 0 0 0 0 0 0 b000000 41040404 ffffffff ffffffff ff000000 ff050505 fff8f8f8 ffffffff 3f101010 b000000 0 0 0 0 0 bd1d1d1 3f000000 ffffffff ff000000 ff040404 fff7f7f7 ffffffff ff000000 ffffffff 20080808 0 0 0 0 b000000 34191919 ffffffff ff040404 ff030303 fff1f1f1 ffffffff ff070707 ff000000 ffffffff 20000000 0 0 0 b171717 340a0a0a fffdfdfd ff020202 ff000000 ffffffff fffcfcfc ff020202 ff000000 ffffffff 35000000 b000000 0 0 b2e2e2e 34000000 ffffffff ff030303 ff000000 ffffffff fffdfdfd ff020202 ff060606 fff6f6f6 340f0f0f b000000 0 0 b000000 340a0a0a ffffffff ff080808 ff000000 ffffffff fff9f9f9 ff040404 ff000000 fffbfbfb 34272727 b000000 0 0 b000000 34000000 ffffffff ff000000 ff010101 fffefefe ffffffff ff030303 ff010101 fffbfbfb 34272727 b000000 0 0 0 20101010 fffbfbfb ff000000 ff010101 fffcfcfc ffffffff ff000000 ff000000 fffdfdfd 34000000 b464646 0 0 0 0 20000000 ffffffff ff000000 ffffffff ffffffff ff000000 ff040404 fffdfdfd 3f000000 ba2a2a2 0 0 0 0 0 b000000 41272727 fff9f9f9 fffefefe ff000000 ff080808 fffefefe fffdfdfd 3f141414 b000000 0 0 0 0 0 0 21080808 fffefefe ff030303 ff000000 ff000000 ff0c0c0c ff000000 fffafafa 20000000 0 0 0 0 0 0 b000000 36000000 ffffffff ffefefef ffffffff fff7f7f7 fffbfbfb ffffffff 20000000 0 0 0 0 0 0 0 b171717 20000000 2a2a2a2a 2a000000 2a1e1e1e 2a000000 20101010 b000000 0 0 0 0 0";
		private const _STR_CURSOR:String = "14 17 ffffffff fff8f8f8 ffffffff fff4f4f4 ffffffff fff6f6f6 ffffffff fffafafa fffefefe ffffffff ffffffff ffffffff fff1f1f1 ffffffff ffffffff 0 0 0 ffffffff ff000000 ff010101 ff020202 ff000000 ff040404 ff000000 ff020202 ff000000 ff000000 ff060606 ff000000 ff020202 fffcfcfc 0 0 0 0 ffffffff ff000000 ff000000 ff070707 ff000000 ff000000 ff000000 ff010101 ff020202 f0000000 ff060606 fffbfbfb 0 0 0 0 0 0 ffffffff ff000000 ff060606 ff040404 ff000000 ff010101 ff000000 ff070707 ff000000 fffafafa 0 0 0 0 0 0 0 0 ffffffff ff000000 ff070707 ff000000 ff000000 ff000000 ff000000 f00e0e0e ff000000 ffffffff ffffffff 0 0 0 0 0 0 0 ffffffff ff000000 ff0a0a0a ff060606 ff000000 ff060606 f0000000 ff000000 ff101010 ff000000 ffffffff ffffffff 0 0 0 0 0 0 fffdfdfd ff000000 ff000000 ff000000 ff0f0f0f fff9f9f9 ffffffff ff000000 ff040404 ff000000 ffffffff 0 0 0 0 0 0 0 ffffffff ff000000 ff050505 fffdfdfd ffffffff fffefefe fff8f8f8 ffffffff ffffffff ffffffff 0 0 0 0 0 0 0 0 fffcfcfc ff020202 ffffffff fffbfbfb ff0b0b0b ff000000 ff060606 fffafafa ffffffff 0 0 0 0 0 0 0 0 0 ffffffff fffafafa ff000000 ff000000 ffffffff ff000000 ff000000 ffffffff 0 0 0 0 0 0 0 0 0 0 ffffffff ff000000 ffffffff ffffffff ffffffff ff000000 ffffffff 0 0 0 0 0 0 0 0 0 0 ffffffff ff000000 ff050505 fff9f9f9 ff010101 ff000000 ffffffff 0 0 0 0 0 0 0 0 0 0 ffffffff fffdfdfd ff010101 ff000000 ff000000 ffffffff ffffffff 0 0 0 0 0 0 0 0 0 0 0 ffffffff ffffffff fffefefe fffdfdfd fffdfdfd 0";
		
		private var _Bmp_resize0:BitmapData;
		private var _Bmp_resize45:BitmapData;
		private var _Bmp_resize90:BitmapData;
		private var _Bmp_resize135:BitmapData;
		private var _Bmp_skew0:BitmapData;
		private var _Bmp_skew45:BitmapData;
		private var _Bmp_skew90:BitmapData;
		private var _Bmp_skew135:BitmapData;
		private var _Bmp_move:BitmapData;
		private var _Bmp_rotation:BitmapData;
		private var _Bmp_6dn:BitmapData;
		private var _Bmp_cursor:BitmapData;
		private var _Bmpcode_class:BmpCode;
		
		private var _shape_arrow:ShapeClass;
		
		public function ArrowShapeClass() 
		{
			_shape_arrow = this;
			_Bmpcode_class = new BmpCode();
		}
		
		public function Show($bmp:BitmapData, $isOrigin:Boolean = false):void
		{
			_shape_arrow.Clear();
			_shape_arrow.FillBitmap($bmp, $isOrigin);
		}
		
		public function get Bmp_resize0():BitmapData 
		{
			if (_Bmp_resize0 == null) {
				_Bmp_resize0=_Bmpcode_class.decode(_STR_RESIZE0);
			}
			return _Bmp_resize0;
		}
		public function get Bmp_resize45():BitmapData 
		{
			if (_Bmp_resize45 == null) {
				_Bmp_resize45=_Bmpcode_class.decode(_STR_RESIZE45);
			}
			return _Bmp_resize45;
		}
		public function get Bmp_resize90():BitmapData 
		{
			if (_Bmp_resize90 == null) {
				_Bmp_resize90=_Bmpcode_class.decode(_STR_RESIZE90);
			}
			return _Bmp_resize90;
		}
		public function get Bmp_resize135():BitmapData 
		{
			if (_Bmp_resize135 == null) {
				_Bmp_resize135=_Bmpcode_class.decode(_STR_RESIZE135);
			}
			return _Bmp_resize135;
		}
		public function get Bmp_skew0():BitmapData 
		{
			if (_Bmp_skew0 == null) {
				_Bmp_skew0=_Bmpcode_class.decode(_STR_SKEW0);
			}
			return _Bmp_skew0;
		}
		public function get Bmp_skew45():BitmapData 
		{
			if (_Bmp_skew45 == null) {
				_Bmp_skew45=_Bmpcode_class.decode(_STR_SKEW45);
			}
			return _Bmp_skew45;
		}
		public function get Bmp_skew90():BitmapData 
		{
			if (_Bmp_skew90 == null) {
				_Bmp_skew90=_Bmpcode_class.decode(_STR_SKEW90);
			}
			return _Bmp_skew90;
		}
		public function get Bmp_skew135():BitmapData 
		{
			if (_Bmp_skew135 == null) {
				_Bmp_skew135=_Bmpcode_class.decode(_STR_SKEW135);
			}
			return _Bmp_skew135;
		}
		public function get Bmp_move():BitmapData 
		{
			if (_Bmp_move == null) {
				_Bmp_move=_Bmpcode_class.decode(_STR_MOVE);
			}
			return _Bmp_move;
		}
		public function get Bmp_rotation():BitmapData 
		{
			if (_Bmp_rotation == null) {
				_Bmp_rotation=_Bmpcode_class.decode(_STR_ROTATION);
			}
			return _Bmp_rotation;
		}
		public function get Bmp_6dn():BitmapData 
		{
			if (_Bmp_6dn == null) {
				_Bmp_6dn=_Bmpcode_class.decode(_STR_6DN);
			}
			return _Bmp_6dn;
		}
		public function get Bmp_cursor():BitmapData 
		{
			if (_Bmp_cursor == null) {
				_Bmp_cursor=_Bmpcode_class.decode(_STR_CURSOR);
			}
			return _Bmp_cursor;
		}
	}
	
}
	import flash.display.BitmapData;
	internal class BmpCode 
	{
		public function decode($str:String):BitmapData 
		{
			var $_Bmp_array:Array = $str.split(" ");
			var $_w:int=$_Bmp_array[0];
			var $_h:int=$_Bmp_array[1];
			var $_Bmp_data:BitmapData = new BitmapData($_w,$_h,true,0x0);
			var $_Bmp_num:int=2;
			$_Bmp_data.lock();
			for (var i:int=0; i<$_w; i++) {
				for (var j:int=0; j<$_h; j++) {
					$_Bmp_data.setPixel32(i,j,uint("0x"+$_Bmp_array[$_Bmp_num]));
					$_Bmp_num++;
				}
			}
			$_Bmp_data.unlock();
			return $_Bmp_data;
		}
	}