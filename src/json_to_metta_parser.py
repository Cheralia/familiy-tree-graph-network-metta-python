def json_to_metta_query(parsed_json):
    """
    Converts {'function_name': 'get-siblings', 'args': ['Chernet']}
    into "! (get-siblings Chernet)"
    """
    func = parsed_json.get("function_name")
    args = parsed_json.get("args", [])
    
    if not func:
        raise ValueError("No function name provided")

    
    formatted_args = " ".join([str(arg) for arg in args])
    
    query = f"! ({func} {formatted_args})"
    return query

def extract_atoms_from_result(result):
    """
    Cleans up the MeTTa output object into a python list/value.
    MeTTa returns [[Atom('Name')]] or [[0.5]].
    """
    clean_results = []
    
    # MeTTa returns a list of lists (one per result expression)
    if not result:
        return []
        
    for item in result:
        # Each item is a list of atoms
        for atom in item:
            val = str(atom)
            # Try to convert numbers
            try:
                if '.' in val:
                    val = float(val)
                else:
                    val = int(val)
            except:
                pass # Keep as string
            clean_results.append(val)
            
    return clean_results