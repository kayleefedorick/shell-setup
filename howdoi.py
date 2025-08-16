#!/usr/bin/env python3
import sys
from interpreter import interpreter

def main():
    question = " ".join(sys.argv[1:])
    interpreter.messages=[]
    interpreter.llm.api_base="http://192.168.1.2:1234/v1"
    interpreter.llm.api_key="fake_key"
    interpreter.llm.model="openai/mistralai/mistral-nemo-instruct-2407"
    interpreter.llm.context_window=10000
    interpreter.llm.temperature=0.3
    interpreter.llm.disable_telemetry=True
    interpreter.llm.supports_functions=True
    interpreter.system_message =           """You are a 'how do I' command running in a Linux terminal. 
                                           You have vast knowledge of Linux, as well as other IT and computing topics.
                                           The system you are running on is:
                                           Linux Mint 22.1, 
                                           Shell: zsh,
                                           Editor: micro,
                                           User: kaylee
                                           The user knows the above configuration and it does not need to be repeated. 
                                           Provide friendly and helpful instructions to the user reading your output.
                                           When providing code, output it as plain text only. Do NOT use code blocks! 
                                           ONLY output commands as plain text without markdown or other formatting.
                                           Do not use the ` character anywhere in your output!
                                           DO NOT OUTPUT CODE BLOCKS. YOU CAN NOT EXECUTE CODE.
                                           YOU ARE NOT ALLOWED TO USE ANY TOOLS OR CALL FUNCTIONS.
                                           Respond only in plain text.
                                           Always end your answer by asking: Do you have any follow-up questions?
                                           Avoid answering questions outside your scope of knowledge."""
    
    interpreter.chat(f"""How do I {question} on Linux Mint 22.1? 
                      Please send me instructions to answer my question and any other useful info.
                      Create a plan and break it into multiple steps if required. 
                      For simple questions (only 1 step), use this format: 
                      To *question*, type: *command* on a single line. Then, on a new line, write 
                      More information: and give a brief explanation of the commands and any 
                      useful arguments or switches. """)

    # Follow-up loop
    while True:
        try:
            follow_up = input("\033[1;33mFollow-up question\033[0m (press Enter to exit): ").strip()
            if not follow_up or follow_up.lower() == "exit":
                print("Goodbye!")
                break
            interpreter.chat(f"""I have a follow-up question related to our last messages. 
                              Please answer my question in detail: {follow_up} """)
        except (EOFError, KeyboardInterrupt):
            print("\nGoodbye!")
            break

if __name__ == "__main__":
    main()
