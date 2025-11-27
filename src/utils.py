import os
from hyperon import MeTTa

# Global MeTTa instance
_metta = None

def get_metta_runner():
    """
    Returns a singleton instance of MeTTa with the family-tree loaded.
    """
    global _metta
    if _metta is None:
        _metta = MeTTa()
        
        # Path to your family-tree.metta file
        # Assuming family-tree.metta is in the parent directory or same level as src
        base_dir = os.path.dirname(os.path.dirname(__file__)) # Go up one level from src
        data_file_path = os.path.join(base_dir, 'family-tree.metta')
        
        if not os.path.exists(data_file_path):
            # Fallback if file is in the same folder
            data_file_path = os.path.join(os.path.dirname(__file__), 'family-tree.metta')

        if not os.path.exists(data_file_path):
            raise FileNotFoundError(f"family-tree.metta not found at {data_file_path}")

        print(f"Loading MeTTa file from: {data_file_path}")
        with open(data_file_path, 'r') as f:
            _metta.run(f.read())
            
    return _metta

def run_metta_query(query_string):
    """
    Executes a raw MeTTa query string and returns the result.
    """
    runner = get_metta_runner()
    return runner.run(query_string)

def append_to_metta_file(new_atoms_string):
    """
    Appends new data to the physical file and reloads the runner.
    """
    base_dir = os.path.dirname(os.path.dirname(__file__))
    data_file_path = os.path.join(base_dir, 'family-tree.metta')
    
    # 1. Append to file
    with open(data_file_path, "a") as f:
        f.write("\n" + new_atoms_string + "\n")
    
    # 2. Run the new lines in the current instance so we don't need to restart
    runner = get_metta_runner()
    runner.run(new_atoms_string)