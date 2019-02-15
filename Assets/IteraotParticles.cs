using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IteraotParticles : MonoBehaviour
{
    public GameObject plane;
    public RenderTexture RT1;
    public RenderTexture RT2;

    void SwapRT()
    {
        var tmp = RT1;
        RT1 = RT2;
        RT2 = tmp;
    }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        var cam = GetComponent<Camera>();
        plane.GetComponent<MeshRenderer>().material.SetTexture("_ParticlesTex", RT2);
        cam.targetTexture = RT1;
        cam.Render();
        SwapRT();

    }
}
