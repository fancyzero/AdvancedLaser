Shader "Unlit/gradient"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_ParticlesTex("_ParticlesTex", 2D) = "white" {}
		_textureSize("Texture Size", Float) = 64
			_speed("Speed", Float) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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

            sampler2D _MainTex;
			sampler2D _ParticlesTex;
            float4 _MainTex_ST;
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

            fixed4 frag (v2f i) : SV_Target
            {
				float2 xx = float2(1,0) / _textureSize;
				float2 yy = float2(0, 1) / _textureSize;
                // sample the texture
				float2 pPos = tex2D(_ParticlesTex, 1-i.uv);
				float value = tex2D(_MainTex, pPos).r; 
				
				float dx = tex2D(_MainTex, pPos + xx).r;
				float dy = tex2D(_MainTex, pPos + yy).r;
                
                
				float2 gradient =  (float2(dx - value, dy - value));
				return float4(gradient * _speed + pPos, 0, 1);
				


            }
            ENDCG
        }
    }
}
