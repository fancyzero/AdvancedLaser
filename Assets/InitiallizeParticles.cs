﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InitiallizeParticles : MonoBehaviour
{
    public GameObject particleItoerator;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        var cam = GetComponent<Camera>();
        cam.Render();
        if (particleItoerator)
            particleItoerator.SetActive(true);
        gameObject.SetActive(false);
    }
}
