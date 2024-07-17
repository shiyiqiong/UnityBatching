using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetDrawMeshInstanced : MonoBehaviour
{
    [SerializeField]
	Mesh mesh = default;
	[SerializeField]
	Material material = default;
    [SerializeField]
	int count = 1000;
    private MaterialPropertyBlock block;
    Matrix4x4[] matrices;
    Vector4[] colors;
    
    void Start()
    {
        matrices = new Matrix4x4[count];
        colors = new Vector4[count];
        for (int i = 0; i < count; i++)
        {
            var pos = new Vector3(Random.Range(-3f, 3f), Random.Range(-5f, 5f), 0);
            matrices[i] = Matrix4x4.TRS(pos, Quaternion.Euler(0f, 0f, 0f), new Vector3(0.2f, 0.2f, 0.2f));
            colors[i] = new Vector4(Random.Range(0f, 1f), Random.Range(0f, 1f), Random.Range(0f, 1f), 1f);
        }
        
    }

    void Update()
    {
        if(block == null)
        {
            block = new MaterialPropertyBlock();
            block.SetVectorArray("_Color", colors);
        }
        Graphics.DrawMeshInstanced(mesh, 0, material, matrices, count, block);
    }
}
