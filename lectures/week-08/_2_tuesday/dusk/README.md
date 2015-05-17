# File Upload w/ Paperclip
Lecture on how to upload files in Rails using [Paperclip](https://github.com/thoughtbot/paperclip).

# Objective
Students will be able to...

- Approach and implement a new gem entirely on their own simply using the README
- Implement their own file upload using Paperclip
- Validate file types

# Link
File uploads are an important of the web and likely to be part of your project's functionality. Here's how you do it.

# Active Learning
Pair up in groups of two. One of you will be the navigator, the other one the driver, meaning only one of you actually codes.

Do the following:

- Clone [this app](https://github.com/sf-wdi-17/paperclip) and cd into it
- Bundle, load the schema, and start the server
- Navigate to /recipes and try crudding some recipes
- Install ImageMagick using `$ brew install imagemagick` (this is needed only the first time you use Paperclip)
- Follow the [paperclip README](https://github.com/thoughtbot/paperclip) to install Paperclip
- After reading the README, add an image attachment called `preview` to your recipes
- Add a file input to the recipe form and show the preview image on the show page
- Validate that the file is an image and that it is only 10mb big (max)

# Reflect
Have the driver reiterate the steps needed to install paperclip. Ask each other questions if anything is unclear. Challenge each other and test each other's knowledge!

We will also go over it together and implement it jointly.

# Now and Then
Paperclip is a great tool that you will probably use repeatedly throughout your career as Rails developer. As a good alternative, you can also check out [Carrierwave](https://github.com/carrierwaveuploader/carrierwave).
