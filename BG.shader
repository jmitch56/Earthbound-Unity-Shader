Shader "Custom/BG" {
	Properties {
        _MainTex("Texture", 2D) = "white" {}
        _RampTex("Ramp Texture", 2D) = "white" {}
        _ColorShiftSpeed("Color Shift Speed", Range(1, 10)) = 1
        _DistortionFrequency("Distortion Frequency", Range(1,256)) = 50
        _DistortionScale("Distortion Scale", Range(0,1)) = 0.1
        _DistortionSpeed("Distortion Speed", Range(0,10)) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
        Pass{
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            sampler2D _RampTex;

            float _ColorShiftSpeed;
            float _DistortionFrequency;
            float _DistortionScale;
            float _DistortionSpeed;

            fixed4 frag(v2f_img i) : SV_Target {
                fixed4 col = tex2D(_MainTex, i.uv + float2(_DistortionScale, 0)*sin((_Time*_DistortionSpeed + i.uv.y)*_DistortionFrequency));
                return tex2D(_RampTex, fixed2(col.r + _Time.x * _ColorShiftSpeed, 0.5));
            }
            ENDCG
        }
	}
	FallBack "Diffuse"
}
