# Hexagonal Consulting Entry Test

## Instructions

Your Client is a French Coworking space that rents workstations to freelancers. When someone is accepted into the coworking space, he signs a contract that is renewed automatically every month. Because of the high demand, the Client needs to put in place a waiting list in order to keep track of people wanting to join the coworking.
The main features that the Client has specified:
* A public accessible form to collect incoming requests (name, email, phone number, a brief biography about the freelancer). Each field must be validated in order to have data as accurate as possible.
* Email addresses must be confirmed (requests with emails that have not been confirmed should not be taken into account by the waiting list).
* The requests will be accepted on a first-come, first served principle
* The requests in the waiting list must be reconfirmed every 3 months: an email should be sent to the people in the waiting list, informing them of their order in the waiting list and asking for confirmation that they are still interested, otherwise their request will be removed from the waiting list (aka expired).
For the scope of this test, an administration interface is not required. However, you need to provide methods that the Client could use in rails console :
* request.accept! - method that will allow accepting a request (request being an instance of the class Request)
* list the requests by their status using class methods or scopes
** Request.unconfirmed - requests for which the email address has not been confirmed
** Request.confirmed - requests in the waiting list
** Request.accepted - requests that have been accepted by the client
** Request.expired - requests that have not been reconfirmed
The app should be hosted on a free Heroku hosting plan.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

This program uses :

```
Ruby 2.6.3
Rails 5.2.3
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
