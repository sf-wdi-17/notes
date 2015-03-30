# HTTP Basics (or how the internet works)
Lecture on http and the basic structure of the internet.

## Learning objectives
By the time this lesson is finished, we should all be able to:
- Understand the basic architecture of the HTTP protocol
- Apply CURL to use HTTP headers and bodies
- Distinguish HTTP action verbs
- Understand the difference between a server and a client
    + And understand how the HTTP protocol is used to allow a client and server to interact
- Replicate the basic structure of the internet

## Link
We are starting our adventure into the land of clients and servers, HTTP requests and responses. This lesson covers the basics of what you need to know about the internet in general and how it works.

## Architecture Of The Internet
Whenever you check your email, watch a video on YouTube, or chat with your friends, it seems like there is one wire connecting you to what you want. It may seem this way, but in fact, the internet is a massive network of networks connecting us all to the things we're looking for. Computers, phones, printers and many other devices are all hooked up to each other as part of "the internet." In fact, when people talk about "the internet", it feels like they are talking about some tangible thing when in fact the internet is truly quite transient. It only exists as long as at least two devices are connected through IP protocols.

Speaking of "IP", every device on the internet has its own, unique address, called its IP address (Internet Protocol address). This address is used to receive and send content to and from a device.

When you open up a website, e.g. Google, you reach it by typing its IP address. For Google, as of March 30, 2015, one of Google's IP addresses is 74.125.239.100. If you go ahead and paste this address into your browser's URL bar, it should take you to Google's website.

### DNS

However, since IP addresses are hard to remember and only just barely readable by human beings, domain names, like "google.com" are used as synonyms.

Let's use google.com as an example to get a somewhat simplified idea of how the internet works:

Your computer is connected to a router -> you open up a browser and open google.com -> your computer sends that address to your router -> your router connects to a DNS server to find the IP address corresponding to google.com -> the DNS server sends you the matching IP address for google.com -> you connect to that IP address -> Google then sends you back information (i.e. the webpage as HTML) -> your browser reads the HTML, parses it, and displays it in a human readable format as a webpage

### Example of connection to google using `traceroute`

To see the networked nature of the internet in action, let's all go into our terminal now, and type in:

`traceroute www.google.com`

Press enter. What response did you get?

### The HTTP Protocol
"HTTP" stands for "Hypertext Transfer Protocol". We've all heard the word "hypertext" as it relates to HTML (which stands for: "hypertext markup language"). But have we ever stopped to consider why its called "hypertext"?

Is it because a bunch of geeks came up with it? Well kind of actually.

But in reality, what makes it "hypertext" instead of just text is the fact that hypertext is intended to have references, which we often call "hyperlinks" or just "links" to other pieces of hypertext. And when you consider the nature of the internet—an interconnected network of networks—it starts to make a lot of sense to use some form of hypertext to display information.

#### Quick quiz:
So if Hypertext is just another way of saying "webpages", then a protocol like HTTP that sends hypertext is what?

Which step in the request flow we described above for `google.com` is HTTP?

### The Request-Response Cycle
What exactly are we referring to when developers talk about the "request-response cycle?" Where is it happening? Who, or what, is taking part in this "cycle?"

The "request-response-cycle" can be illustrated as follows:

![Client to server flow](http://www.tenouk.com/visualcplusmfc/setupiisnweb_files/image001.png)


### Components of an HTTP response:

An HTTP response contains:
  - A header
  - And a body

The header contains, among other things, two very important pieces of information: 
  - the response status
  - the HTTP verb.  

Most commonly, the response status will be "OK" (code 200), and the HTTP verbs will be "GET" (to retrieve data) and "POST" (to create data).

So what does the body contain?
  - If the response status is 200 (AKA, "OK")
      + The body is expected to contain the data you (or the client) requested
  - If the response status is 404, or another error
      + The body may (or may not) contain additional information about the error, why it happened, etc.

The chain from client (your computer) to server can be replicated using [Curl](http://curl.haxx.se/). So let's get some CURL practice in together:

### Interactive Learning with CURL and Google

Let's all open a new window in terminal. At the prompt, type:

```bash
curl http://www.google.com
```

If everything worked correctly, the HTTP protocol should have returned a response that looks a lot like HTML. What do you think we got back?

Ok, now let's try something else, instead of just typing http://www.google.com/ as the argument to CURL, let's try putting in a different URL, namely: `https://www.google.com/?q=taylor+swift`.

What do you think is going to happen now?

```bash
curl https://www.google.com/search?q=taylor+swift
```

Now what are we getting back? And what did we change exactly?

If you don't see a difference in the HTTP response, let's try opening up Google Chrome and going to that same URL `https://www.google.com/?q=taylor+swift`.

Now do you know what was different about the second URL? What did we add/change? What happened as a result?s

#### Ok, who really cares about CURL?
You might be asking yourself "why use CURL when I already have a web browser?" The answer is that CURL gives us another way to interact with servers on the internet (and as we'll see, a bit closer to home as well), and to find out what 'response' we get when we make a 'request'. And because CURL gives us the actual response, rather than a "rendered" version of a response, we can get a "raw" picture of how a server responds to different requests.

In fact, CURL is so useful to us developers, that we should get some practice using it before we move on to the next step. Let's all open a web browser and go to:
[CURL Practice](http://httpkit.com/resources/HTTP-from-the-Command-Line/).
