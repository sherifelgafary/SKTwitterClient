# SKTwitterClient
SKTwitterClient is a twitter client app that you can use your twitter account and save it to the device settings, get a list of your followers in list or grid view you can check any follower latest 10 tweets and choose any account saved on your device to get it's follower list also you can choose between the arabic and english languages versions in the app.


## Architecture:-
SKTwitterClient is built using enhanced-MVC architecture as it's a small scooped project so the mvc would fit in this situation perfectly but i have tried to change a bit as to make each model responsible for making the apis request and returning a ready model data to the view controller instead of making the viewController responsible for the requests or creating a API class responsible for all the app APIS calls also creating a baseViewController and a baseModel so if any time i want to create a feature that can propagate through out all my inheriting classes it could be done easily like in the showing splash screen animation and overriding the create instance class method


## Twitter functionalities:-
Firstly i have used Twitter IOS kit and implemented the twitter login afterwards trying to implement the other functionalities using twitter REST APIS it needed handling OAuthintication so i found STTWITTER third party library that helped into this aspect so it have removed the responsibility of creating a service layer and handling OAUTH process and also the revalidation of the user's credentials if it's still valid or not yes the twitter's user token doesn't expire but the user could reject the app permission then the twitter's token would be invalid so i choose to verify the credential’s at the app start so i could handle such case from the scenario start.


## Twitter Authentication process:-
I have choose to make the authentication process done through a webView instead of redirecting the user to safari as to make the process more intuative and consistent on the other side some skeptical users may be afraid or think twice of inserting their credentials thinking in-App usage of credentials may be unsecure or i might use it or store it as plain text so it's hackable actually i was thinking in a UX were i could allow the user to choose the scenario between the two approaches that's more convenient to his case but i couldn't reach a user friendly approach for this due to timing concerns


## User credentials security:-
Regarding this matter firstly i used to save the user session by storing the user object in the userdefaults but after giving it some thought i decided to only store the user's authentication token's in the keychain of the mobile as when saved in the userdefault's the data is saved in plain unencrypted state so a jail broken iphone can easily acquire his authentication tokens which would be a security breach then so i preferred to only save the user's tokens in the keychain as it's saved encrypted there and when verifying the user's credentials using the tokens in the app's launching i would retrieve then the other needed data so then the user's data are now saved securely and in lightweight sate 
