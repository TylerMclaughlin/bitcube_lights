# Bitcube_lights

Using Python to generate complex GLSL pixel shader code for the Bitcube installation and controlling the lights with a MIDI piano keyboard.


## Generative GLSL

Using base shader code is nice for building dynamical interacting systems between pixels and running it on the GPU. But this coding language can be tedious to work with, and harder to try out higher-order transformations.

I use Python's `itertools` for combinatorics and `NumPy` for stochastics and random number functions to generate complex GLSL code.  

My first test of this was making a arbitrarily complex cellular automata, which can be extended to more interesting systems involving nodes interacting with the state of neighboring or distant nodes.

Here's an example of the shader code output by the Python program (hundreds of lines long, so this is just a shortened version).  Such repetitive conditional expressions would be impossible tweak, keep track of, or edit in a systematic way.

```GLSL
void main()
{
    float A = get(0, 3);
    float B = get(-1, 2);
    float C = get(0, -5);
    float D = get(1, 1);
    float E = get(-4, 4);

    float r = 0.0;

    if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.0 && E == 0.0){
        r = 0.25;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.0 && E == 0.25){
        r = 0.5;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.0 && E == 0.5){
        r = 1.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.0 && E == 0.75){
        r = 1.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.0 && E == 1.0){
        r = 0.25;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.25 && E == 0.25){
        r = 1.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.25 && E == 0.5){
        r = 0.25;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.25 && E == 0.75){
        r = 1.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.25 && E == 1.0){
        r = 0.75;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.5 && E == 0.5){
        r = 1.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.5 && E == 0.75){
        r = 0.25;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.5 && E == 1.0){
        r = 1.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.75 && E == 0.75){
        r = 1.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 0.75 && E == 1.0){
        r = 0.5;
    }else if (A == 0.0 && B == 0.0 && C == 0.0 && D == 1.0 && E == 1.0){
        r = 0.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.25 && D == 0.25 && E == 0.25){
        r = 0.25;
    }else if (A == 0.0 && B == 0.0 && C == 0.25 && D == 0.25 && E == 0.5){
        r = 0.5;
    }else if (A == 0.0 && B == 0.0 && C == 0.25 && D == 0.25 && E == 0.75){
        r = 1.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.25 && D == 0.25 && E == 1.0){
        r = 0.0;
    }else if (A == 0.0 && B == 0.0 && C == 0.25 && D == 0.5 && E == 0.5){
        r = 0.75;
    }else if (A == 0.0 && B == 0.0 && C == 0.25 && D == 0.5 && E == 0.75){
        r = 0.75;
    }else if (A == 0.0 && B == 0.0 && C == 0.25 && D == 0.5 && E == 1.0){
        r = 0.25;
```

## MIDI reactivity
