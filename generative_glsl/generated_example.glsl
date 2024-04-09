float get(int x, int y)
{
    vec2 uv = vUV.st + vec2(x,y)*uTD2DInfos[0].res.xy;

    if (uv.x < 0){
        uv.x = uv.x + 1;
    }else if (uv.x > 1){
        uv.x = uv.x - 1;
    }

    return texture(sTD2DInputs[0], uv).r;
}


out vec4 fragColor;
void main()
{
    float A = get(-1, 0);
    float B = get(0, -1);
    float C = get(1, 1);
    float D = get(-5, 3);
    float E = get(-1, 2);

    float r = 0.0;

    if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.0 && E == 0.0){
        r = 1.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.0 && E == 0.5){
        r = 0.5;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.0 && E == 1.0){
        r = 0.5;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.5 && E == 0.5){
        r = 0.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.5 && E == 1.0){
        r = 0.5;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 1.0 && E == 1.0){
        r = 0.5;
    }else if (A == 0.0 && B == 0.0 && C == 0.5 && D == 0.5 && E == 0.5){
        r = 0.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.5 && D == 0.5 && E == 1.0){
        r = 0.5;
    }else if (A == 0.0 && B == 0.0 && C == 0.5 && D == 1.0 && E == 1.0){
        r = 0.5;
    }else if (A == 0.0 && B == 0.0 && C == 1.0 && D == 1.0 && E == 1.0){
        r = 0.5;
    }else if (A == 0.0 && B == 0.5 && C == 0.5 && D == 0.5 && E == 0.5){
        r = 1.0;
    }else if (A == 0.0 && B == 0.5 && C == 0.5 && D == 0.5 && E == 1.0){
        r = 1.0;
    }else if (A == 0.0 && B == 0.5 && C == 0.5 && D == 1.0 && E == 1.0){
        r = 0.5;
    }else if (A == 0.0 && B == 0.5 && C == 1.0 && D == 1.0 && E == 1.0){
        r = 1.0;
    }else if (A == 0.0 && B == 1.0 && C == 1.0 && D == 1.0 && E == 1.0){
        r = 0.5;
    }else if (A == 0.5 && B == 0.5 && C == 0.5 && D == 0.5 && E == 0.5){
        r = 1.0;
    }else if (A == 0.5 && B == 0.5 && C == 0.5 && D == 0.5 && E == 1.0){
        r = 0.5;
    }else if (A == 0.5 && B == 0.5 && C == 0.5 && D == 1.0 && E == 1.0){
        r = 1.0;
    }else if (A == 0.5 && B == 0.5 && C == 1.0 && D == 1.0 && E == 1.0){
        r = 0.5;
    }else if (A == 0.5 && B == 1.0 && C == 1.0 && D == 1.0 && E == 1.0){
        r = 1.0;
    }else if (A == 1.0 && B == 1.0 && C == 1.0 && D == 1.0 && E == 1.0){
        r = 1.0;
    }

    vec4 color = vec4(vec3(r),1);
    fragColor = TDOutputSwizzle(color);
}

