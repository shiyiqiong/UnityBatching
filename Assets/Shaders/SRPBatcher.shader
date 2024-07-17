// Upgrade NOTE: commented out 'float4 unity_DynamicLightmapST', a built-in variable
// Upgrade NOTE: commented out 'float4 unity_LightmapST', a built-in variable

Shader "Unlit/SRPBatcher"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            //将材质自定义属性，放在UnityPerMaterial的CBuffer中
            CBUFFER_START(UnityPerMaterial)
                float4 _Color;
            CBUFFER_END

            //将Unity内置属性，放在UnityPerDraw的CBuffer中（直接include URP的Libraray已经设置了）
            // CBUFFER_START(UnityPerDraw)
            //     // Space block Feature
            //     float4x4 unity_ObjectToWorld;
            //     float4x4 unity_WorldToObject;
            //     float4 unity_LODFade; // x is the fade value ranging within [0,1]. y is x quantized into 16 levels
            //     real4 unity_WorldTransformParams; // w is usually 1.0, or -1.0 for odd-negative scale transforms

            //     // Light Indices block feature
            //     // These are set internally by the engine upon request by RendererConfiguration.
            //     real4 unity_LightData;
            //     real4 unity_LightIndices[2];

            //     float4 unity_ProbesOcclusion;

            //     // Reflection Probe 0 block feature
            //     // HDR environment map decode instructions
            //     real4 unity_SpecCube0_HDR;

            //     // Lightmap block feature
            //     // float4 unity_LightmapST;
            //     // float4 unity_DynamicLightmapST;

            //     // SH block feature
            //     real4 unity_SHAr;
            //     real4 unity_SHAg;
            //     real4 unity_SHAb;
            //     real4 unity_SHBr;
            //     real4 unity_SHBg;
            //     real4 unity_SHBb;
            //     real4 unity_SHC;
            // CBUFFER_END

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return fixed4(_Color.rgb, 1);
            }
            ENDCG
        }
    }
}
