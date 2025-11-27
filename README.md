# 🌳 Family Tree AI & Knowledge Graph (Python + MeTTa + Streamlit)

Ask natural questions about a family tree, run MeTTa logic under the hood, and get friendly answers. Built with OpenCog Hyperon (MeTTa), Streamlit, and Google Gemini.

Repo: https://github.com/Cheralia/familiy-tree-graph-network-metta-python.git

## Features
- Chat interface to query relationships (siblings, parents, cousins, ethnicity%).
- Data entry UI to append new people, relationships, and ethnicity facts to family-tree.metta.
- MeTTa execution via Hyperon Python bindings.
- LLM-powered intent parsing and natural language answers.

## Project Structure
- apps.py — Streamlit app (UI: chat + data entry)
- family-tree.metta — MeTTa knowledge base (facts and rules)
- src/
  - json_to_metta_parser.py — builds MeTTa queries from parsed intents and cleans results
  - text_to_json_parser.py — LLM parser for user questions and natural answers
  - utils.py — MeTTa runner wrapper and file append helper

Expected tree after clone:

- familiy-tree-graph-network-metta-python/
  - apps.py
  - family-tree.metta
  - README.md
  - src/
    - json_to_metta_parser.py
    - text_to_json_parser.py
    - utils.py

## Prerequisites
- Python 3.10+ recommended
- A Google Gemini API key (GEMINI_API_KEY)
- Platform build tools for installing Hyperon (see below)

## Quick Start

1) Clone the repo
- git clone https://github.com/Cheralia/familiy-tree-graph-network-metta-python.git
- cd familiy-tree-graph-network-metta-python

2) Create and activate a virtual environment
- python -m venv .venv
- On Windows: .venv\Scripts\activate
- On macOS/Linux: source .venv/bin/activate

3) Install dependencies
- pip install -r requirements.txt

If you don’t have a requirements.txt yet, create one with at least:
- streamlit
- python-dotenv
- google-generativeai
- hyperon
Example:
streamlit
python-dotenv
google-generativeai
hyperon

Note: If hyperon wheel is unavailable for your platform, follow Hyperon installation docs or use:
- pip install hyperon
If this fails, consult: https://github.com/trueagi-io/hyperon-experimental or your platform’s instructions.

4) Set your Gemini API key
Create a .env file in the project root:
GEMINI_API_KEY=your_api_key_here

5) Run the app
- streamlit run apps.py
Open the provided local URL in your browser.

## How It Works

- UI (apps.py):
  - “Ask the Family Tree”: You type a question.
  - The app calls parse_question_to_json to map the question to a MeTTa function and args.
  - json_to_metta_query builds a MeTTa query string, which is executed by run_metta_query.
  - extract_atoms_from_result normalizes MeTTa output.
  - generate_natural_answer turns results into a friendly sentence.

- “Add Family Data”:
  - Append new Parent/Ethnicity atoms to family-tree.metta via append_to_metta_file.
  - Changes are immediately loaded into the current MeTTa runner.

## Examples

Questions to try:
- Who are Chernet’s siblings?
- Who is Kaleb’s uncle?
- What percent Oromo is Chernet?
- List the nieces of Genet.

Data to add:
- Parent-Child: (Male Abebe) and (Parent Abebe Kebede)
- Ethnicity: (Ethnicity Selam Oromo 0.5)

## Troubleshooting

- ModuleNotFoundError: hyperon
  - Ensure the venv is active and run pip install hyperon.
- GEMINI_API_KEY not found
  - Create .env at project root or export environment variable before running.
- family-tree.metta not found
  - Ensure the file exists at project root. utils.py searches project root first, then src.

## Security Notes

- Your Gemini API key is read from .env; do not commit it.
- The app appends to family-tree.metta exactly what you submit; ensure inputs are trusted.

## License

MIT (or the license in the repository).
