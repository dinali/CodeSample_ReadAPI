Purpose: 

Display the USDA ERS APIs available at http://api.ers.usda.gov/. The APIs return JSON. This application demonstrates how to return the data on an iPhone.

Getting Started:

1) In the mainViewController, replace the global variable kURL with the URL of the API that you would like to test. A key is required for Federal Agency apps hosted on http://api.data.gov. 

2) Run the URL in a browser to display the JSON data.

3) Create a new class in the Model folder. Create a property to capture each field in the JSON data feed that you'd like to display. For example, if the data feed returns a description field, you would create a NSString *description property.

4) Modify the GroupBuilder.h class to use your new class. GroupBuilder serializes the JSON data into your custom class.

5) In mainViewController.m in the cellForRowAtIndexPath method, update the code to reference your custom class.

Release date: December 2013, XCode 4.6, iOS 6