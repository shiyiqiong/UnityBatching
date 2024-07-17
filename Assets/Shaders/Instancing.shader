Shader "Unlit/Instancing"
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
            //1.添加Shader变体，使得shader有开启GPU Instance 选项
            #pragma multi_compile_instancing
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            //2.添加Instance库文件
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                //3.将InstanceId注入顶点着色器输入结构体
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                //4.将InstanceId注入顶点着色器输出结构体
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            
            UNITY_INSTANCING_BUFFER_START(UnityPerMaterial)
                UNITY_DEFINE_INSTANCED_PROP(float4, _Color) //声明一个Instancing颜色属性
            UNITY_INSTANCING_BUFFER_END(UnityPerMaterial)

            v2f vert (appdata v)
            {
                v2f o;
                //5.InstanceId相关设置
                UNITY_SETUP_INSTANCE_ID(v);
                //6.传递InstanceID（顶点 -> 片元）
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //7.InstanceId相关设置
                UNITY_SETUP_INSTANCE_ID(i);
                //访问一个Instancing颜色属性
                float4 col = UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial, _Color);
                return fixed4(col.rgb, 1);
            }
            ENDCG
        }
    }
}
