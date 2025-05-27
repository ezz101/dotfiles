local GEMENI_URL = "https://generativelanguage.googleapis.com/v1beta/openai/"
local GEMENI_MODEL = "gemini-2.0-flash"

local OPENAI_URL = "https://api.openai.com/v1"
local OPENAI_MODEL = "gpt-4o"

require("avante").setup({
	provider = "openai",
	openai = {
		endpoint = GEMENI_URL,
		model = GEMENI_MODEL,
		timeout = 30000,
		temperature = 0,
		max_completion_tokens = 8192,
	},
})
