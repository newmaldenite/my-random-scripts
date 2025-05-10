#!/bin/bash

# Supported LLM providers
LLM_PROVIDERS=("OpenAI" "Gemini" "Claude" "Llama" "Mistral" "All")

# A function to install dependencies based on LLM provider
install_dependencies() {
    echo "Installing core Langchain dependencies..."
    pip install langchain langchain-core langchain-community python-dotenc --quiet

    case $1 in
        "OpenAI")
            echo "Installing OpenAI dependencies..."
            pip install langchain-openai openai --quiet
            ;;
        "Gemini")
            echo "Installing Gemini dependencies..."
            pip install langchain-google-genai google-genai --quiet
            ;;
        "Claude")
            echo "Installing Claude dependencies..."
            pip install langchain-anthropic anthropic --quiet
            ;;
        "Meta (Llama)")
            echo "Installing Meta (Llama) dependencies..."
            pip install langchain-ollama ollama --quiet
            ;;
        "Mistral AI")
            echo "Installing Mistral AI dependencies..."
            pip install langchain-mistralai mistralai --quiet
            ;;
        "All")
            echo "Installing all major LLM provider dependencies..."
            pip install \
                langchain-openai openai \
                langchain-google-genai google-generativeai \
                langchain-anthropic anthropic \
                langchain-ollama ollama \
                langchain-mistralai mistralai \
                --quiet
            ;;
        *)
            echo "Unknown provider. Installing core LangChain only."
            ;;
    esac

    echo "✅ Dependencies installed!"
}