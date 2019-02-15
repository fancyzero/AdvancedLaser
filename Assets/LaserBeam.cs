using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LaserBeam : MonoBehaviour
{
    Mesh mesh;
    public Vector2 start=Vector2.zero;
    public Vector2 end = Vector2.up;
    public float Length
    {
        get
        {
            return (start - end).magnitude;
        }
        set
        {
            end = start + Dir * value;
        }
    }
    public Vector2 Dir
    {
        get { return (end - start).normalized; }
        set { end = start + value * Length; }
    }

    public float width;
    public float segmentSize;
    // Start is called before the first frame update
    void Start()
    {
        mesh = new Mesh();
        var verts = new List<Vector3>();
        var indices = new List<int>();
        var uvs = new List<Vector2>();
        for (int i = 0; i < Length / segmentSize + 1; i++)
        {
            verts.Add(new Vector3(-width / 2,i*segmentSize,0));
            verts.Add(new Vector3(width / 2, i * segmentSize, 0));
            uvs.Add(new Vector2(0.5f,i/ Length));
            uvs.Add(new Vector2(0.5f,i/Length));
            if (i > 1)
            {
                if (i % 2 == 0)
                {
                    indices.Add(i);
                    indices.Add(i - 2);
                    indices.Add(i - 1);
                }
                else
                {
                    indices.Add(i);
                    indices.Add(i - 1);
                    indices.Add(i - 2);

                }
            }
        }
        
        mesh.SetVertices(verts);
        mesh.SetUVs(0, uvs);
        mesh.SetIndices(indices.ToArray(), MeshTopology.Triangles, 0);
        GetComponent<MeshFilter>().mesh = mesh;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
