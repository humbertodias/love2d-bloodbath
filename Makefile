# Project name
PROJECT_NAME := bloobath

# Game source directory (change if needed)
SOURCE_DIR := .

# Output files
LOVE_FILE := $(PROJECT_NAME).love
ZIP_FILE := matt-game.zip

# List of files to include in the package
INCLUDE_FILES := $(wildcard $(SOURCE_DIR)/**/*) $(wildcard $(SOURCE_DIR)/*)

# Run the game
run:
	@echo "Running ..."
	@love .

# Default rule (creates the .love file)
all: $(LOVE_FILE)

# Rule to create the .love file
$(LOVE_FILE): $(INCLUDE_FILES)
	@echo "Packaging files into $(LOVE_FILE)..."
	@zip -9 -r $(LOVE_FILE) $(SOURCE_DIR) -x "*.git*" "*.DS_Store*"
	@echo "$(LOVE_FILE) has been successfully created!"

# Rule to create a regular ZIP file
zip: $(INCLUDE_FILES)
	@echo "Creating a standard ZIP file: $(ZIP_FILE)..."
	@zip -9 -r $(ZIP_FILE) $(SOURCE_DIR) -x "*.git*" "*.DS_Store*"
	@echo "$(ZIP_FILE) has been successfully created!"

# Clean up old builds and remove .DS_Store recursively
clean:
	@echo "Cleaning up files..."
	@rm -f $(LOVE_FILE) $(ZIP_FILE)
	@find $(SOURCE_DIR) -name ".DS_Store" -type f -delete
	@echo "Cleanup complete. Removed $(LOVE_FILE), $(ZIP_FILE), and all .DS_Store files."

# Help command
help:
	@echo "Available commands:"
	@echo "  make         - Creates the $(LOVE_FILE)"
	@echo "  make zip     - Creates a standard ZIP file: $(ZIP_FILE)"
	@echo "  make clean   - Removes the $(LOVE_FILE) and $(ZIP_FILE)"
	@echo "  make help    - Displays this help message"

.PHONY: all clean help zip
