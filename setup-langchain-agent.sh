#!/bin/bash

# Supported LLM providers
LLM_PROVIDERS=("OpenAI" "Gemini" "Claude" "Llama" "Mistral" "All")

# A function to install dependencies based on LLM provider
install_dependencies() {
    echo "Installing core Langchain dependencies..."
    pip install langchain langchain-core langchain-community python-dotenv --quiet

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

# Function to generate .env file with placeholders
generate_env_file() {
    cat <<EOL > .env
# Place your API keys here
LANGCHAIN_TRACING_V2=true
LANGCHAIN_API_KEY=your_langchain_api_key_here

EOL

    case $1 in
        "OpenAI")
            echo "OPENAI_API_KEY=your_openai_api_key_here" >> .env
            ;;
        "Google Gemini")
            echo "GOOGLE_API_KEY=your_google_api_key_here" >> .env
            ;;
        "Anthropic Claude")
            echo "ANTHROPIC_API_KEY=your_anthropic_api_key_here" >> .env
            ;;
        "Mistral AI")
            echo "MISTRAL_API_KEY=your_mistral_api_key_here" >> .env
            ;;
        "All")
            echo "OPENAI_API_KEY=your_openai_api_key_here" >> .env
            echo "GOOGLE_API_KEY=your_google_api_key_here" >> .env
            echo "ANTHROPIC_API_KEY=your_anthropic_api_key_here" >> .env
            echo "MISTRAL_API_KEY=your_mistral_api_key_here" >> .env
            ;;
    esac

    echo "📄 Created .env file with placeholder API keys."
}

# === Main Script Logic ===

echo "Welcome to the LangChain Agent Setup Tool"
echo "Select your main LLM provider:"
select PROVIDER in "${LLM_PROVIDERS[@]}"; do
    if [ 1 -le "$REPLY" ] && [ "$REPLY" -le ${#LLM_PROVIDERS[@]} ]; then
        SELECTED_PROVIDER=${LLM_PROVIDERS[$((REPLY-1))]}
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

echo "You selected: $SELECTED_PROVIDER"

install_dependencies "$SELECTED_PROVIDER"
generate_env_file "$SELECTED_PROVIDER"

echo ""
echo "🎉 Setup complete!"
echo "Next steps:"
echo "1. Review and fill out the .env file with your actual API keys."
echo "2. Start building your agent in Python using LangChain."