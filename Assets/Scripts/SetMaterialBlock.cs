using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetMaterialBlock : MonoBehaviour
{
    public Color color;
    void Start()
    {
        var block = new MaterialPropertyBlock();
        block.SetColor("_Color", color);
        GetComponent<Renderer>().SetPropertyBlock(block);
    }

}
