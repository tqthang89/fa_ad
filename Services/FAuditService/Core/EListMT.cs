using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FAuditService.Core
{
    public class EListMT
    {

        public static bool CheckEmployeeMT(int EId)
        {
            bool _Value = false;
            List<int> list = new List<int>();
            list.Add(2873);
            list.Add(2929);
            list.Add(2723);
            list.Add(2754);
            list.Add(2838);
            list.Add(2839);
            list.Add(2920);
            list.Add(2766);
            list.Add(2829);
            list.Add(2927);
            list.Add(2811);
            list.Add(2826);
            list.Add(2772);
            list.Add(2722);
            list.Add(2837);
            list.Add(2812);
            list.Add(2726);
            list.Add(2724);
            list.Add(2730);
            list.Add(2737);
            list.Add(2841);
            list.Add(2733);
            list.Add(2815);
            list.Add(2752);
            list.Add(2759);
            list.Add(2808);
            list.Add(2734);
            list.Add(2836);
            list.Add(2735);
            list.Add(2921);
            list.Add(2767);
            list.Add(2721);
            list.Add(2842);
            list.Add(2814);
            list.Add(2819);
            list.Add(2807);
            list.Add(2782);
            list.Add(2784);
            list.Add(2774);
            list.Add(2786);
            list.Add(2731);
            list.Add(2748);
            list.Add(2739);
            list.Add(2874);
            list.Add(2763);
            list.Add(2817);
            list.Add(2757);
            list.Add(2744);
            list.Add(2720);
            list.Add(2777);
            list.Add(2809);
            list.Add(2810);
            list.Add(2830);
            list.Add(2804);
            list.Add(2831);
            list.Add(2806);
            list.Add(2749);
            list.Add(2775);
            list.Add(2778);
            list.Add(2745);
            list.Add(2818);
            list.Add(2803);
            list.Add(2907);
            list.Add(2835);
            list.Add(2918);
            list.Add(2770);
            list.Add(2785);
            list.Add(2824);
            list.Add(2779);
            list.Add(2746);
            list.Add(2801);
            list.Add(2740);
            list.Add(2816);
            list.Add(2871);
            list.Add(2832);

            if (list.Exists(p => p == EId) == true)
                _Value = true;

            return _Value;
        }
    }
}