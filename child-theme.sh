#!/bin/bash

# Script to create a child theme in WordPress

# Prompt user for the name of the parent theme
read -p "Enter the name of the parent theme: " parent_theme

# Set the name of the child theme
child_theme="$parent_theme-child"

# Use the current working directory as the themes directory
themes_directory="$(pwd)"

# Create a new directory for the child theme
child_theme_directory="$themes_directory/$child_theme"

# Check if the directory already exists
if [ -d "$child_theme_directory" ]; then
    echo "Error: The child theme directory '$child_theme_directory' already exists."
    exit 1
fi

# Attempt to create the child theme directory
mkdir "$child_theme_directory"

# Check if the directory creation was successful
if [ $? -ne 0 ]; then
    echo "Error: Unable to create the child theme directory '$child_theme_directory'. Check your permissions."
    exit 1
fi

# Create style.css file for the child theme
cat <<EOL > "$child_theme_directory/style.css"
/*
 Theme Name:   $child_theme
 Theme URI:    http://example.com/$child_theme/
 Description:  Child theme for $parent_theme
 Author:       Your Name
 Author URI:   http://example.com
 Template:     $parent_theme
 Version:      1.0.0
*/

/* Add your custom styles below this line */
EOL

# Create functions.php file for the child theme
cat <<EOL > "$child_theme_directory/functions.php"
<?php
// Enqueue parent theme stylesheet
function enqueue_parent_theme_style() {
    wp_enqueue_style('$parent_theme-style', get_template_directory_uri() . '/style.css');
}
add_action('wp_enqueue_scripts', 'enqueue_parent_theme_style');
?>
EOL

# Create functions.js file for the child theme
cat <<EOL > "$child_theme_directory/functions.js"
// Your custom JavaScript functions go here
console.log('Hello from $child_theme functions.js!');
EOL

# Create style.css file for the child theme
cat <<EOL > "$child_theme_directory/style.css"
/* Your custom CSS styles go here */
body {
    background-color: #f0f0f0;
}
EOL

echo "Child theme created successfully at $child_theme_directory"
