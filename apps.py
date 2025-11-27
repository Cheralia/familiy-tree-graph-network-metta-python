import streamlit as st
import json
from src.text_to_json_parser import parse_question_to_json, generate_natural_answer
from src.json_to_metta_parser import json_to_metta_query, extract_atoms_from_result
from src.utils import run_metta_query, append_to_metta_file


st.set_page_config(page_title="MeTTa Family Tree AI", page_icon="🌳", layout="wide")

st.title("🌳 Family Tree AI & Knowledge Graph")
st.markdown("Powered by **OpenCog Hyperon (MeTTa)** and **Gemini**.")

# Tabs for Chat vs Data Entry
tab1, tab2 = st.tabs(["💬 Ask the Family Tree", "➕ Add Family Data"])

# ==========================================
# TAB 1: Chat Interface
# ==========================================
with tab1:
    col1, col2 = st.columns([1, 1])

    with col1:
        st.subheader("Ask a Question")
        with st.form(key='query_form'):
            question_input = st.text_input(
                "Enter your question:", 
                value="Who are Chernet's siblings?",
                help="Try: 'Who is Kaleb's uncle?', 'What percent Oromo is Chernet?'"
            )
            submit_button = st.form_submit_button(label='🚀 Run Query')
        
        st.info("**Example Questions:**\n- *Who are the cousins of Chernet?*\n- *Who is the grandfather of Kaleb?*\n- *What percent Amhara is Selam?*\n- *List the nieces of Genet.*")

    with col2:
        st.subheader("Results")
        if submit_button and question_input:
            with st.spinner("Analyzing logic..."):
                try:
                    
                    parsed_intent = parse_question_to_json(question_input)
                    
                    if not parsed_intent:
                        st.error("Could not understand the question. Please try again.")
                    else:
                        st.caption(f"**Detected Intent:** `{parsed_intent['function_name']}` Args: `{parsed_intent['args']}`")
                        
                        
                        metta_query = json_to_metta_query(parsed_intent)
                        
                        
                        raw_result = run_metta_query(metta_query)
                        clean_result = extract_atoms_from_result(raw_result)
                        
                        # 4. Generate Natural Language Answer
                        final_answer = generate_natural_answer(question_input, clean_result)
                        
                        st.success(final_answer)
                        
                        with st.expander("🛠️ Debug Information"):
                            st.text(f"MeTTa Code Executed:\n{metta_query}")
                            st.text(f"Raw Atom Result:\n{raw_result}")
                            st.text(f"Parsed Python Result:\n{clean_result}")

                except Exception as e:
                    st.error(f"An error occurred: {e}")

# ==========================================
# TAB 2: Manage Data
# ==========================================
with tab2:
    st.header("Expand the Knowledge Graph")
    
    st.markdown("Add new people, relationships, or ethnicity data to `family-tree.metta`.")
    
    type_choice = st.selectbox("What do you want to add?", ["Parent-Child Relationship", "Ethnicity Data"])
    
    if type_choice == "Parent-Child Relationship":
        with st.form("add_rel_form"):
            col_a, col_b, col_c = st.columns(3)
            parent_name = col_a.text_input("Parent Name (e.g. Abebe)").title()
            child_name = col_b.text_input("Child Name (e.g. Kebede)").title()
            parent_gender = col_c.selectbox("Parent Gender", ["Male", "Female"])
            
            submitted = st.form_submit_button("Add Relationship")
            
            if submitted and parent_name and child_name:
                # Construct MeTTa atoms
                # 1. Define Gender: (Male Abebe)
                # 2. Define Parent: (Parent Abebe Kebede)
                new_data = f"({parent_gender} {parent_name})\n(Parent {parent_name} {child_name})"
                
                try:
                    append_to_metta_file(new_data)
                    st.success(f"Successfully added: {parent_name} is the parent of {child_name}")
                except Exception as e:
                    st.error(f"Error saving data: {e}")

    elif type_choice == "Ethnicity Data":
        with st.form("add_eth_form"):
            col_a, col_b, col_c = st.columns(3)
            name = col_a.text_input("Person Name").title()
            group = col_b.text_input("Ethnic Group (e.g. Oromo)").title()
            percent = col_c.number_input("Percentage (0.0 to 1.0)", min_value=0.0, max_value=1.0, step=0.1)
            
            submitted = st.form_submit_button("Add Ethnicity")
            
            if submitted and name and group:
                # (Ethnicity Name Group Value)
                new_data = f"(Ethnicity {name} {group} {percent})"
                
                try:
                    append_to_metta_file(new_data)
                    st.success(f"Successfully added: {name} is {percent*100}% {group}")
                except Exception as e:
                    st.error(f"Error saving data: {e}")

    st.divider()
    st.info("ℹ️ Note: Data is saved immediately to `family-tree.metta`. You can switch back to the Chat tab and ask about the new people immediately!")