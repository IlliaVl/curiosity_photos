# Curiosity Photos

Flutter app that fetches data from an open API and Firebase and displays it on the screen.
The API endpoint to fetch the data is `https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY`.

## How to launch

Steps to launch app:

1. Create or add to the root directory of project .env file with the following line:
   NASA_API_KEY=DEMO_KEY
Where DEMO_KEY is the key received in `https://api.nasa.gov`. Replace it with the real value.
   
2. Run `dart run build_runner build --delete-conflicting-outputs` from the root directory of the project.
It will create `env.g.dart` file.

3. Launch app as usual Flutter project.