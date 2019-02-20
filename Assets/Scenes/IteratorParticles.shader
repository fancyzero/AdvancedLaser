﻿Shader "Unlit/flow"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_ParticlesTex("_ParticlesTex", 2D) = "white" {}
		_textureSize("Texture Size", Float) = 64
		_speed("Speed", Float) = 0.1
		_steps("steps",Int) = 1
		_slowdown("slow down", Float) = 0.8
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        LOD 100
		blend One Zero
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };
			float _slowdown;
            sampler2D _MainTex;
			sampler2D _ParticlesTex;
            float4 _MainTex_ST;
			int _steps;
			float _speed;
			float _textureSize;
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

			float2 gradient(float2 uv)
			{
				
				float2 puv = uv - 0.5;
				//float x = puv.x;
				//float y = puv.y;
				//float2 dir = float2(x*x-y*y,2*x*y);
				//return (float2(-puv.y,puv.x));
				float2 xx = float2(1, 0) / _textureSize;
				float2 yy = float2(0, 1) / _textureSize;
				float v = tex2D(_MainTex, uv);
				float vx = tex2D(_MainTex, uv + xx);
				float vy = tex2D(_MainTex, uv + yy);
				return float2(-( vy - v), vx - v);
			}

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
				float2 pPos = tex2D(_ParticlesTex, i.uv).xy;
				float2 v = tex2D(_ParticlesTex, i.uv).zw;
				float l = _speed / _steps;
				for (int i = 0; i < _steps; i++)
				{
					gradient(pPos) + v;
					v = v- _slowdown/_steps;
					pPos = gradient(pPos)*l + pPos;
				}
				return float4( pPos, v);


            }
            ENDCG
        }
    }
}
