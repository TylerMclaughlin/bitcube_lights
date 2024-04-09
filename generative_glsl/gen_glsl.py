import numpy as np
import string
from itertools import combinations_with_replacement

main_header = '\nout vec4 fragColor;\nvoid main()\n{'

def read_template(template_name):
    with open('templates/' + template_name + '.txt', 'r') as f:
        data = f.read()
    return data 

def random_input_cells(n_points, x_rand_max, y_rand_max):
    #TODO:  figure out how to do upper quadrant, rotate, full-2D 

    zero_zero_exists = True
    duplicate_column_exists = True
    input_cells = None
    while zero_zero_exists or duplicate_column_exists:
        x_randoms = np.random.choice(x_rand_max, n_points)
        y_randoms = np.random.choice(y_rand_max, n_points)
        input_cells = np.array([x_randoms, y_randoms]) 
        input_cells = input_cells - np.mean(input_cells).astype(int)
        zero_zero_exists = (input_cells.sum(axis = 0) == 0).any()
        if np.unique(input_cells, axis = 1).shape[1] == input_cells.shape[1] and not zero_zero_exists:
            duplicate_column_exists = False

    return input_cells

def array_to_input_glsl(array, numeric_type = 'float'):

    variables = list(string.ascii_uppercase)[:array.shape[1]]

    lines = []
    for i, l in enumerate(variables):
        lines.append(f'{l} = get({array[0,i]}, {array[1,i]});')

    line_connector = f'\n    {numeric_type} '                                                
    output =  line_connector + line_connector.join(lines)
    return output


def float_conditions(n_inputs, s_states):
    variables = list(string.ascii_uppercase)[:n_inputs]
    all_states = [round(s_i/(s_states - 1), 4) for s_i in range(s_states)]
    #print(variables)
    #print(all_states)
    all_state_combos = list(combinations_with_replacement(all_states, n_inputs))
    c_state_combos = len(all_state_combos)
    r_values = np.random.choice(all_states, c_state_combos)
    all_eqs = []
    for combo in all_state_combos:
        pair = list(zip(variables, combo))
        eq_ = [x + ' == ' + str(y) for (x, y) in pair]
        eq = ' && '.join(eq_)
        all_eqs.append(eq)

    # GLSL code generation
    condition_string = '\n\n    float r = 0.0;\n\n'
    for i, e in enumerate(all_eqs):
        if i == 0:
            condition_string += '    if (' 
        else:
            condition_string += '    }else if ('
        condition_string += (f'{all_eqs[i]})' + '{')
        condition_string += f'\n        r = {r_values[i]};\n' 
    main_tail = '    }\n\n    vec4 color = vec4(vec3(r),1);\n    fragColor = TDOutputSwizzle(color);\n}'
    condition_string += main_tail
    return condition_string


def gen_float(n_inputs, s_states):
    # load up 'get()' function template, may or may not include periodic boundary conditions
    g_template = read_template('get_periodic_x')
    # make code for input cell coordinates
    a = random_input_cells(n_inputs, 3, 4)
    input_code = array_to_input_glsl(a)
    # make code for input cells
    fc = float_conditions(n_inputs, s_states)
    print(g_template + main_header + input_code + fc)





if __name__ == '__main__':
    gen_float(3, 5)
