# Bitcube lights

Two small projects for programming the BitCube, a climbable, multi-story LED art installation.

The first project is using Python to generate complex GLSL pixel shader code for the BitCube's 288 lights.

The second project was controlling the BitCube's lights with a MIDI piano keyboard.


## Generative GLSL

"Write decent code that generates terrible code" -- my bio-inspired philosophy for creative coding projects.

Using base shader code is nice for building dynamical interacting systems between pixels and running it on the GPU. But this coding language can be tedious to work with, and it's hard to try out higher-order transformations.

I use Python's `itertools` for combinatorics and `NumPy` for stochastics and random number functions to "print" complex GLSL code.  The output can be regenerated and randomized differently every time.

My first test of this was to make families of arbitrarily complex cellular automata.  These can be extended to more interesting discrete dynamical systems, i.e., anything involving nodes interacting with the state of other (neighboring or distant) nodes.  

Here's an example of the shader code output by the Python program (hundreds of lines long, so this is just a shortened version).  Such repetitive conditional expressions would be impossible tweak, manage, or edit in a systematic way.

```GLSL
void main()
{
    # get the current state at 5 different nodes, each specified by a relative (x,y) coordinate
    float A = get(0, 3);
    float B = get(-1, 2);
    float C = get(0, -5);
    float D = get(1, 1);
    float E = get(-4, 4);

    # r represents the output value of each pixel
    # initialize it.
    float r = 0.0;

    # change the pixels based on the multi-state of the 5 input nodes.
    # since this is shader code, it specifies what EVERY pixel should be doing, in parallel.
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

For MIDI control of the bitcube, I came up with a mapping from the 88 keys on a piano to the 224 lights.  
Each row is a different octave. The rows are 28 cubes wide, so I made each of the 12 notes two cubes wide, except for the 4 notes that spanning the corners; those were 3 cubes long.  The patch is velocity sensitive, so playing louder will affect the brightness.
