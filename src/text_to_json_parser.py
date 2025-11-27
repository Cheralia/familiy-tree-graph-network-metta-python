import os
import json
import google.generativeai as genai
from dotenv import load_dotenv

load_dotenv()
KEY = os.getenv("GEMINI_API_KEY")

if KEY:
    genai.configure(api_key=KEY)
    model = genai.GenerativeModel('gemini-2.5-flash')
else:
    raise RuntimeError("GEMINI_API_KEY not found")


AVAILABLE_FUNCTIONS = [
    "get-brothers", "get-sisters", "get-siblings",
    "get-father", "get-mother", "get-parents",
     "get-uncles", "get-aunt", "get-aunts",
    "get-cousin", "get-cousins",
    "get-grandparent", "get-grand-father", "get-grand-mother",
    "get-grandchild",
    "get-niece", "get-nieces", "get-nephew", "get-nephews",
    "get-ethnicity", "get-children", "get-sons",
    "get-daughters", "get-wife", "get-husband", "get-relations"
]

def parse_question_to_json(question):
    """
    Uses LLM to map a user question to a function name and arguments.
    """
    
    prompt = f"""
    You are a specialized parser for a Family Tree expert system.
    
    Your goal is to map the user's question to ONE of the following MeTTa functions:
    {AVAILABLE_FUNCTIONS}

    Rules:
    1. Most functions take 1 argument (the Name of the person).
    2. 'get-ethnicity' takes 2 arguments: (PersonName, EthnicityGroup).
    3. Ignore capitalization differences, but keep names Proper Case.
    4. If the question asks about a relationship (like "Who is X's brother"), map it to the getter (e.g., 'get-brothers').
    5. If the question asks "What percent Oromo is Chernet?", map to 'get-ethnicity' with args ["Chernet", "Oromo"].
    6. If the user is asking question which is out of familiy tree relashion ship concept tell user formally you are familiy tree AI Assistant and ask only related thing

    Output strictly a JSON object:
    {{
        "function_name": "exact_function_name_from_list",
        "args": ["arg1", "arg2"...]
    }}

    User Question: "{question}"
    """

    try:
        response = model.generate_content(prompt)
        text = response.text
        
        # Clean up markdown if present
        if "```json" in text:
            text = text.split("```json")[1].split("```")[0].strip()
        elif "```" in text:
            text = text.split("```")[1].split("```")[0].strip()
            
        return json.loads(text)
    except Exception as e:
        print(f"LLM Parse Error: {e}")
        return None

def generate_natural_answer(question, metta_result):
    """
    Takes the raw MeTTa result (which might be a list of atoms) and writes a nice sentence.
    """
    prompt = f"""
    User Question: "{question}"
    Database Result: {metta_result}
    
    The result comes from a MeTTa family tree engine.
    1. If the result is empty or [[]], say "No information found."
    2. If the result is a number (like 0.25), format it as a percentage (25%).
    3. If the result is a list of names, list them clearly.
    
    Write a brief, friendly response.
    """
    try:
        response = model.generate_content(prompt)
        return response.text.strip()
    except:
        return f"Raw Result: {metta_result}"