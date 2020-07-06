# <img src="src/test/resources/karate-logo.svg" height="60" width="60"/> Karate
## Test Automation Made `Simple.`

Karate is an open-source API test automation tool. API tests are written using Behaviour Driven Development (BDD) Gherkin syntax. Unlike other BDD frameworks like Cucumber, Specflow or JBehave, Karate has all the step definitions written for us so we don’t have to worry about writing them. This enables even non-developers to easily write API tests for the services

## Sample

<img src="src/test/resources/sample.jpg" height="400" />

> If you are familiar with Cucumber / Gherkin, the [*big difference*](#cucumber-vs-karate) here is that you **don't** need to write extra "glue" code or Java "step definitions" !

It is worth pointing out that JSON is a 'first class citizen' of the syntax such that you can express payload and expected data without having to use double-quotes and without having to enclose JSON field names in quotes.  There is no need to 'escape' characters like you would have had to in Java or other programming languages.

And you don't need to create additional Java classes for any of the payloads that you need to work with.

# Index

<table>
<tr>
  <th>Start</th>
  <td>
      <a href="#maven">Maven</a> 
  </td>
</tr>
<tr>
  <th>Run</th>
  <td>
    | <a href="#command-line">Command Line</a>
    | <a href="#ide-support">IDE Support</a>    
    | <a href="#tags">Tags / Grouping</a>
    | <a href="#parallel-execution">Parallel Execution</a>
  </td>
</tr>
<tr>
  <th>Report</th>
  <td>
      <a href="#configuration">Configuration</a> 
    | <a href="#test-reports">Reports</a>
    | <a href="#junit-html-report">JUnit HTML Report</a>
  </td>
</tr>
<tr>
  <th>Types</th>
  <td>
      <a href="#json">JSON</a> 
    | <a href="#xml">XML</a>
    | <a href="#javascript-functions">JavaScript Functions</a>
    | <a href="#reading-files">Reading Files</a>
    | <a href="#karate-expressions">Karate Expressions</a>
  </td>
</tr>
<tr>
  <th>Variables</th>
  <td>
      <a href="#def"><code>def</code></a>
    | <a href="#text"><code>text</code></a>
    | <a href="#table"><code>table</code></a>
    | <a href="#csv"><code>csv</code></a>
  </td>
</tr>
<tr>
  <th>Actions</th>
  <td>
      <a href="#assert"><code>assert</code></a>
    | <a href="#print"><code>print</code></a>
    | <a href="#configure"><code>configure</code></a>
    | <a href="#call"><code>call</code></a> 
    | <a href="#reading-files"><code>read()</code></a>
  </td>
</tr>
<tr>
  <th>HTTP</th>
  <td>
      <a href="#url"><code>url</code></a> 
    | <a href="#path"><code>path</code></a>
    | <a href="#request"><code>request</code></a>
    | <a href="#method"><code>method</code></a>
    | <a href="#status"><code>status</code></a>
  </td>
</tr>
<tr>
  <th>Request</th>
  <td>
      <a href="#param"><code>param</code></a> 
    | <a href="#header"><code>header</code></a>    
  </td>
</tr>
<tr>
  <th>Response</th>
  <td>
      <a href="#response"><code>response</code></a>
    | <a href="#responsestatus"><code>responseStatus</code></a>
  </td>
</tr>
<tr>
  <th>Assert</th>
  <td>
      <a href="#match"><code>match ==</code></a>
    | <a href="#match-contains"><code>match contains</code></a>
    | <a href="#fuzzy-matching">Fuzzy Matching</a>
    | <a href="#schema-validation">Schema Validation</a>
  </td>
</tr>
<tr>
  <th>Re-Use</th>
  <td>
      <a href="#calling-other-feature-files">Calling Other <code>*.feature</code> Files</a>
    | <a href="#data-driven-features">Data Driven Features</a>       
    | <a href="#data-driven-tests">Data Driven Scenarios</a>    
  </td>
</tr>
</table>

# Features
* Java knowledge is not required and even non-programmers can write tests
* Scripts are plain-text, require no compilation step or IDE, and teams can collaborate using Git / standard SCM
* Based on the popular Cucumber / Gherkin standard - with [IDE support](https://github.com/intuit/karate/wiki/IDE-Support) and syntax-coloring options
* Scripts can [call other scripts](#calling-other-feature-files) - which means that you can easily re-use and maintain authentication and 'set up' flows efficiently, across multiple tests
* Embedded JavaScript engine that allows you to build a library of [re-usable functions](#calling-javascript-functions) that suit your specific environment or organization
* Re-use of payload-data and user-defined functions across tests is [so easy](#reading-files) - that it becomes a natural habit for the test-developer
* Support for [data-driven tests](#data-driven-tests) and being able to [tag or group](#tags) tests is built-in, no need to rely on an external framework
* Built-in [test-reports](#test-reports) compatible with Cucumber so that you have the option of using third-party (open-source) maven-plugins for even [better-looking reports](karate-demo#example-report)

## Maven
Karate is designed so that you can choose between the [Apache](https://hc.apache.org/index.html) or [Jersey](https://jersey.java.net) HTTP client implementations.

So you need two `<dependencies>`:

```xml
<dependency>
    <groupId>com.intuit.karate</groupId>
    <artifactId>karate-apache</artifactId>
    <version>0.9.5</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>com.intuit.karate</groupId>
    <artifactId>karate-junit5</artifactId>
    <version>0.9.5</version>
    <scope>test</scope>
</dependency>
```

## Command Line
Normally in dev mode, you will use your IDE to run a `*.feature` file directly or via the companion 'runner' JUnit Java class. When you have a 'runner' class in place, it would be possible to run it from the command-line as well.

You can choose a single test to run like this:

```
mvn test -Dtest=CatsRunner
```

When your Java test "runner" is linked to multiple feature files, which will be the case when you use the recommended [parallel runner](#parallel-execution), you can narrow down your scope to a single feature (or even directory) via the command-line, useful in dev-mode. Note how even [tags](#tags) to exclude (or include) can be specified using the [Karate options](#karate-options).

```
mvn test -Dkarate.options="--tags ~@ignore classpath:demo/cats/cats.feature" -Dtest=DemoTestParallel
```

## Parallel Execution
Karate can run tests in parallel, and dramatically cut down execution time. This is a 'core' feature and does not depend on JUnit, Maven or Gradle. 

* You can easily "choose" features and tags to run and compose test-suites in a very flexible manner.
* You can use the returned `Results` object to check if any scenarios failed, and to even summarize the errors
* [JUnit XML](https://wiki.jenkins-ci.org/display/JENKINS/JUnit+Plugin) reports will be generated in the "`reportDir`" path you specify, and you can easily configure your CI to look for these files after a build (for e.g. in `**/*.xml` or `**/surefire-reports/*.xml`)
* [Cucumber JSON reports](https://relishapp.com/cucumber/cucumber/docs/formatters/json-output-formatter) will be generated side-by-side with the JUnit XML reports and with the same name, except that the extension will be `.json` instead of `.xml`

### Parallel Execution
```java
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class TestParallel {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:animals").tags("~@ignore").parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
```

* The `Runner.path()` is how you refer to the package you want to execute, and all feature files within sub-directories will be picked up
* `Runner.path()` takes multiple string parameters, so you can refer to multiple packages or even individual `*.feature` files and easily "compose" a test-suite
  * e.g. `Runner.path("classpath:animals", "classpath:some/other/package.feature")`
* To [choose tags](#tags), call the `tags()` API, note that in the example above, any `*.feature` file tagged as `@ignore` will be skipped - as the `~` prefix means a "NOT" operation. You can also specify tags on the [command-line](#test-suites). The `tags()` method also takes multiple arguments, for e.g.
  * this is an "AND" operation: `tags("@customer", "@smoke")`
  * and this is an "OR" operation: `tags("@customer,@smoke")`
* `parallel()` *has* to be the last method called, and you pass the number of parallel threads needed. It returns a `Results` object that has all the information you need - such as the number of passed or failed tests.

### Parallel Stats
For convenience, some stats are logged to the console when execution completes, which should look something like this:

```
======================================================
elapsed:   2.35 | threads:    5 | thread time: 4.98 
features:    54 | ignored:   25 | efficiency: 0.42
scenarios:  145 | passed:   145 | failed: 0
======================================================
```

The parallel runner will always run `Feature`-s in parallel. Karate will also run `Scenario`-s in parallel by default. So if you have a `Feature` with multiple `Scenario`-s in it - they will execute in parallel, and even each `Examples` row in a `Scenario Outline` will do so ! 

A `timeline.html` file will also be saved to the report output directory mentioned above (`target/surefire-reports` by default) - which is useful for visually verifying or troubleshooting the effectiveness of the test-run.

### `@parallel=false`
In rare cases you may want to suppress the default of `Scenario`-s executing in parallel and the special [`tag`](#tags) `@parallel=false` can be used. If you place it above the [`Feature`](#script-structure) keyword, it will apply to all `Scenario`-s. And if you just want one or two `Scenario`-s to NOT run in parallel, you can place this tag above only *those* `Scenario`-s. See [example](karate-demo/src/test/java/demo/encoding/encoding.feature).

## Test Reports
Most CI tools would be able to process the JUnit XML output of the [parallel runner](#parallel-execution) and determine the status of the build as well as generate reports.

For example, here below is an actual report generated by the [cucumber-reporting](https://github.com/damianszczepanik/cucumber-reporting) open-source library.  

<img src="karate-demo/src/test/resources/karate-maven-report.jpg" height="600px"/>

This report is recommended especially because Karate's integration includes the HTTP request and response logs [in-line with the test report](https://twitter.com/KarateDSL/status/899671441221623809), which is extremely useful for troubleshooting test failures.

<img src="karate-demo/src/test/resources/karate-maven-report-http.jpg" height="600px"/>

# Configuration
> You can skip this section and jump straight to the [Syntax Guide](#syntax-guide) if you are in a hurry to get started with Karate. Things will work even if the `karate-config.js` file is not present.

## Classpath
The 'classpath' is a Java concept and is where some configuration files such as the one for [logging](#logging) are expected to be by default. If you use the Maven `<test-resources>` tweak [described earlier](#folder-structure) (recommended), the 'root' of the classpath will be in the `src/test/java` folder, or else would be `src/test/resources`.

## `karate-config.js`

The only 'rule' is that on start-up Karate expects a file called `karate-config.js` to exist on the 'classpath' and contain a [JavaScript function](#javascript-functions). The function is expected to return a JSON object and all keys and values in that JSON object will be made available as script variables.

```javascript    
function fn() {   
  var env = karate.env; // get java system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev'; // a custom 'intelligent' default
  }
  var config = { // base config JSON
    appId: 'my.app.id',
    appSecret: 'my.secret',
    someUrlBase: 'https://some-host.com/v1/auth/',
    anotherUrlBase: 'https://another-host.com/v1/'
  };
  if (env == 'stage') {
    // over-ride only those that need to be
    config.someUrlBase = 'https://stage-host/v1/auth';
  } else if (env == 'e2e') {
    config.someUrlBase = 'https://e2e-host/v1/auth';
  }
  // don't waste time waiting for a connection or if servers don't respond within 5 seconds
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}
```

## Reading Files
Karate makes re-use of payload data, utility-functions and even other test-scripts as easy as possible. Teams typically define complicated JSON (or XML) payloads in a file and then re-use this in multiple scripts. Keywords such as [`set`](#set) and [`remove`](#remove) allow you to to 'tweak' payload-data to fit the scenario under test. You can imagine how this greatly simplifies setting up tests for boundary conditions. And such re-use makes it easier to re-factor tests when needed, which is great for maintainability.

> Note that the [`set` (multiple)](#set-multiple) keyword can build complex, nested JSON (or XML) from scratch in a data-driven manner, and you may not even need to read from files for many situations. Test data can be within the main flow itself, which makes scripts highly readable.

Reading files is achieved using the built-in JavaScript function called `read()`. By default, the file is expected to be in the same folder (package) and side-by-side with the `*.feature` file. But you can prefix the name with `classpath:` in which case the ['root' folder](#classpath) would be `src/test/java` (assuming you are using the [recommended folder structure](#folder-structure)).

Prefer [`classpath:`](#classpath) when a file is expected to be heavily re-used all across your project.  And yes, relative paths will work.

```cucumber
# json
* def someJson = read('some-json.json')
* def moreJson = read('classpath:more-json.json')

# xml
* def someXml = read('../common/my-xml.xml')

# import yaml (will be converted to json)
* def jsonFromYaml = read('some-data.yaml')

# csv (will be converted to json)
* def jsonFromCsv = read('some-data.csv')

# string
* def someString = read('classpath:messages.txt')

# javascript (will be evaluated)
* def someValue = read('some-js-code.js')

# if the js file evaluates to a function, it can be re-used later using the 'call' keyword
* def someFunction = read('classpath:some-reusable-code.js')
* def someCallResult = call someFunction

# the following short-cut is also allowed
* def someCallResult = call read('some-js-code.js')
```

You can also [re-use other `*.feature`](#calling-other-feature-files) files from test-scripts:

```cucumber
# perfect for all those common authentication or 'set up' flows
* def result = call read('classpath:some-reusable-steps.feature')
```

When a *called* feature depends on some side-by-side resources such as JSON or JS files, you can use the `this:` prefix to ensure that relative paths work correctly - because by default Karate calculates relative paths from the "root" feature or the top-most "caller".

```cucumber
* def data = read('this:payload.json')
```

If a file does not end in `.json`, `.xml`, `.yaml`, `.js`, `.csv` or `.txt`, it is treated as a stream - which is typically what you would need for [`multipart`](#multipart-field) file uploads.

```cucumber
* def someStream = read('some-pdf.pdf')
```

> The `.graphql` and `.gql` extensions are also recognized (for GraphQL) but are handled the same way as `.txt` and treated as a string.

For JSON and XML files, Karate will evaluate any [embedded expressions](#embedded-expressions) on load. This enables more concise tests, and the file can be re-usable in multiple, data-driven tests.

Since it is internally implemented as a JavaScript function, you can mix calls to `read()` freely wherever JavaScript expressions are allowed:

```cucumber
* def someBigString = read('first.txt') + read('second.txt')
```

> Tip: you can even use JS expressions to dynamically choose a file based on some condition: `* def someConfig = read('my-config-' + someVariable + '.json')`. Refer to [conditional logic](#conditional-logic) for more ideas.

And a very common need would be to use a file as the [`request`](#request) body:

```cucumber
Given request read('some-big-payload.json')
```

Or in a [`match`](#match):

```cucumber
And match response == read('expected-response-payload.json')
```

The rarely used `file:` prefix is also supported. You could use it for 'hard-coded' absolute paths in dev mode, but is obviously not recommended for CI test-suites. A good example of where you may need this is if you programmatically write a file to the `target` folder, and then you can read it like this:

```cucumber
* def payload = read('file:target/large.xml')
```

To summarize the possible prefixes:

Prefix | Description
------ | -----------
`classpath:` | relative to the [classpath](#classpath), recommended for re-usable features 
`file:` | do not use this unless you know what you are doing, see above
`this:` | when in a *called* feature, ensure that files are resolved relative to the current feature file

Take a look at the [Karate Demos](karate-demo) for real-life examples of how you can use files for validating HTTP responses, like this one: [`read-files.feature`](karate-demo/src/test/java/demo/read/read-files.feature).

# Karate Expressions
Before we get to the HTTP keywords, it is worth doing a recap of the various 'shapes' that the right-hand-side of an assignment statement can take:

 Example | Shape | Description
-------- | ----- | -----------
`* def foo = 'bar'` | JS | simple strings, numbers or booleans
`* def foo = 'bar' + baz[0]` | JS | any valid JavaScript expression, and variables can be mixed in, another example: `bar.length + 1`
`* def foo = { bar: '#(baz)' }` | JSON | anything that starts with a `{` or a `[` is parsed as JSON, use [`text`](#text) instead of [`def`](#def) if you need to suppress the default behavior
`* def foo = ({ bar: baz })` | JS | [enclosed JavaScript](#enclosed-javascript), the result of which is exactly equivalent to the above
`* def foo = <foo>bar</foo>` | XML | anything that starts with a `<` is parsed as XML, use [`text`](#text) instead of [`def`](#def) if you need to suppress the default behavior
`* def foo = function(arg){ return arg + bar }` | JS Fn | anything that starts with `function(...){` is parsed as a JS function.
`* def foo = read('bar.json')` | JS | using the built-in [`read()`](#reading-files) function
`* def foo = $.bar[0]` | JsonPath | short-cut JsonPath on the [`response`](#response)
`* def foo = /bar/baz` | XPath | short-cut XPath on the [`response`](#response)
`* def foo = get bar $..baz[?(@.ban)]` | [`get`](#get) JsonPath | [JsonPath](https://github.com/json-path/JsonPath#path-examples) on the variable `bar`, you can also use [`get[0]`](#get-plus-index) to get the first item if the JsonPath evaluates to an array - especially useful when using wildcards such as `[*]` or [filter-criteria](#jsonpath-filters)
`* def foo = $bar..baz[?(@.ban)]` | $var.JsonPath | [convenience short-cut](#get-short-cut) for the above
`* def foo = get bar count(/baz//ban)` | [`get`](#get) XPath | XPath on the variable `bar`
`* def foo = karate.pretty(bar)` | JS | using the [built-in `karate` object](#the-karate-object) in JS expressions
`* def Foo = Java.type('com.mycompany.Foo')` | JS-Java | [Java Interop](#java-interop), and even package-name-spaced one-liners like `java.lang.System.currentTimeMillis()` are possible
`* def foo = call bar { baz: '#(ban)' }` | [`call`](#call) | or [`callonce`](#callonce), where expressions like [`read('foo.js')`](#reading-files) are allowed as the object to be called or the argument
`* def foo = bar({ baz: ban })` | JS | equivalent to the above, JavaScript function invocation

# Core Keywords
They are `url`, `path`, `request`, `method` and `status`.

These are essential HTTP operations, they focus on setting one (un-named or 'key-less') value at a time and therefore don't need an `=` sign in the syntax.

## `url`
```cucumber
Given url 'https://myhost.com/v1/cats'
```
A URL remains constant until you use the `url` keyword again, so this is a good place to set-up the 'non-changing' parts of your REST URL-s.

A URL can take expressions, so the approach below is legal.  And yes, variables can come from global [config](#configuration).
```cucumber
Given url 'https://' + e2eHostName + '/v1/api'
```

If you are trying to build dynamic URLs including query-string parameters in the form: `http://myhost/some/path?foo=bar&search=true` - please refer to the [`param`](#param) keyword.

## `path`
REST-style path parameters.  Can be expressions that will be evaluated.  Comma delimited values are supported which can be more convenient, and takes care of URL-encoding and appending '/' where needed.
```cucumber
Given path 'documents/' + documentId + '/download'

# this is equivalent to the above
Given path 'documents', documentId, 'download'

# or you can do the same on multiple lines if you wish
Given path 'documents'
And path documentId
And path 'download'
```
Note that the `path` 'resets' after any HTTP request is made but not the `url`. The [Hello World](#hello-world) is a great example of 'REST-ful' use of the `url` when the test focuses on a single REST 'resources'. Look at how the `path` did not need to be specified for the second HTTP `get` call since `/cats` is part of the `url`.

> Important: If you attempt to build a URL in the form `?myparam=value` by using `path` the `?` will get encoded into `%3F`. Use either the [`param`](#param) keyword, e.g.: `* param myparam = 'value'` or [`url`](#url): `* url 'http://example.com/v1?myparam'`

## `request`
In-line JSON:
```cucumber
Given request { name: 'Billie', type: 'LOL' }
```
In-line XML:
```cucumber
And request <cat><name>Billie</name><type>Ceiling</type></cat>
```
From a [file](#reading-files) in the same package.  Use the `classpath:` prefix to load from the [classpath](#classpath) instead.
```cucumber
Given request read('my-json.json')
```
You could always use a variable:
```cucumber
And request myVariable
```
In most cases you won't need to set the `Content-Type` [`header`](#header) as Karate will automatically do the right thing depending on the data-type of the `request`.

Defining the `request` is mandatory if you are using an HTTP `method` that expects a body such as `post`. If you really need to have an empty body, you can use an empty string as shown below, and you can force the right `Content-Type` header by using the [`header`](#header) keyword.

```cucumber
Given request ''
And header Content-Type = 'text/html'
```

Sending a [file](#reading-files) as the entire binary request body is easy (note that [`multipart`](#multipart-file) is different):

```cucumber
Given path 'upload'
And request read('my-image.jpg')
When method put
Then status 200
```

## `method`
The HTTP verb - `get`, `post`, `put`, `delete`, `patch`, `options`, `head`, `connect`, `trace`.

Lower-case is fine.
```cucumber
When method post
```

It is worth internalizing that during test-execution, it is upon the `method` keyword that the actual HTTP request is issued. Which suggests that the step should be in the `When` form, for example: `When method post`. And steps that follow should logically be in the `Then` form. Also make sure that you complete the set up of things like [`url`](#url), [`param`](#param), [`header`](#header), [`configure`](#configure) etc. *before* you fire the `method`.

```cucumber
# set headers or params (if any) BEFORE the method step
Given header Accept = 'application/json'
When method get
# the step that immediately follows the above would typically be:
Then status 200
```

Although rarely needed, variable references or [expressions](#karate-expressions) are also supported:

```cucumber
* def putOrPost = (someVariable == 'dev' ? 'put' : 'post')
* method putOrPost
```

## `status`
This is a shortcut to assert the HTTP response code.
```cucumber
Then status 200
```
And this assertion will cause the test to fail if the HTTP response code is something else.

See also [`responseStatus`](#responsestatus) if you want to do some complex assertions against the HTTP status code.

# Keywords that set key-value pairs
They are `param`, `header`, `cookie`, `form field` and `multipart field`. 

The syntax will include a '=' sign between the key and the value.  The key should not be within quotes.

> To make dynamic data-driven testing easier, the following keywords also exist: [`params`](#params), [`headers`](#headers), [`cookies`](#cookies-json) and [`form fields`](#form-fields). They use JSON to build the relevant parts of the HTTP request.

## `param` 
Setting query-string parameters:
```cucumber
Given param someKey = 'hello'
And param anotherKey = someVariable
```

The above would result in a URL like: `http://myhost/mypath?someKey=hello&anotherKey=foo`. Note that the `?` and `&` will be automatically inserted.

Multi-value params are also supported:
```cucumber
* param myParam = 'foo', 'bar'
```

You can also use JSON to set multiple query-parameters in one-line using [`params`](#params) and this is especially useful for dynamic data-driven testing.

## `header`

You can use [functions](#calling-javascript-functions) or [expressions](#karate-expressions):
```cucumber
Given header Authorization = myAuthFunction()
And header transaction-id = 'test-' + myIdString
```

It is worth repeating that in most cases you won't need to set the `Content-Type` header as Karate will automatically do the right thing depending on the data-type of the [`request`](#request).

Because of how easy it is to set HTTP headers, Karate does not provide any special keywords for things like 
the [`Accept`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept) header. You simply do 
something like this:

```cucumber
Given path 'some/path'
And request { some: 'data' }
And header Accept = 'application/json'
When method post
Then status 200
```

A common need is to send the same header(s) for _every_ request, and [`configure headers`](#configure-headers) (with JSON) is how you can set this up once for all subsequent requests. And if you do this within a `Background:` section, it would apply to all `Scenario:` sections within the `*.feature` file.

```cucumber
* configure headers = { 'Content-Type': 'application/xml' }
```

Note that `Content-Type` had to be enclosed in quotes in the JSON above because the "`-`" (hyphen character) would cause problems otherwise. Also note that "`; charset=UTF-8`" would be appended to the `Content-Type` header that Karate sends by default, and in some rare cases, you may need to suppress this behavior completely. You can do so by setting the `charset` to null via the [`configure`](#configure) keyword:

```cucumber
* configure charset = null
```

If you need headers to be dynamically generated for each HTTP request, use a JavaScript function with [`configure headers`](#configure-headers) instead of JSON.

Multi-value headers (though rarely used in the wild) are also supported:
```cucumber
* header myHeader = 'foo', 'bar'
```

Also look at the [`headers`](#headers) keyword which uses JSON and makes some kinds of dynamic data-driven testing easier.

# Payload Assertions
## Prepare, Mutate, Assert.
Now it should be clear how Karate makes it easy to express JSON or XML. If you [read from a file](#reading-files), the advantage is that multiple scripts can re-use the same data.

Once you have a [JSON or XML object](#native-data-types), Karate provides multiple ways to manipulate, extract or transform data. And you can easily assert that the data is as expected by comparing it with another JSON or XML object.

## `match`
### Payload Assertions / Smart Comparison
The `match` operation is smart because white-space does not matter, and the order of keys (or data elements) does not matter. Karate is even able to [ignore fields you choose](#ignore-or-validate) - which is very useful when you want to handle server-side dynamically generated fields such as UUID-s, time-stamps, security-tokens and the like.

The match syntax involves a double-equals sign '==' to represent a comparison (and not an assignment '=').

Since `match` and `set` go well together, they are both introduced in the examples in the section below.

### `match` and variables
In case you were wondering, variables (and even expressions) are supported on the right-hand-side. So you can compare 2 JSON (or XML) payloads if you wanted to:
```cucumber
* def foo = { hello: 'world', baz: 'ban' }
* def bar = { baz: 'ban', hello: 'world' }
* match foo == bar
```

## Fuzzy Matching
### Ignore or Validate
When expressing expected results (in JSON or [XML](#match-and-xml)) you can mark some fields to be ignored when the match (comparison) is performed.  You can even use a regular-expression so that instead of checking for equality, Karate will just validate that the actual value conforms to the expected pattern.

This means that even when you have dynamic server-side generated values such as UUID-s and time-stamps appearing in the response, you can still assert that the full-payload matched in one step.

```cucumber
* def cat = { name: 'Billie', type: 'LOL', id: 'a9f7a56b-8d5c-455c-9d13-808461d17b91' }
* match cat == { name: '#ignore', type: '#regex [A-Z]{3}', id: '#uuid' }
# this will fail
# * match cat == { name: '#ignore', type: '#regex .{2}', id: '#uuid' }	
```

> Note that regex escaping has to be done with a *double* back-slash - for e.g: `'#regex a\\.dot'` will match `'a.dot'`

The supported markers are the following:

Marker | Description
------ | -----------
`#ignore` | Skip comparison for this field even if the data element or JSON key is present
`#null` | Expects actual value to be `null`, and the data element or JSON key *must* be present
`#notnull` | Expects actual value to be not-`null`
`#present` | Actual value can be any type or *even* `null`, but the key *must* be present (only for JSON / XML, see below)
`#notpresent` | Expects the key to be **not** present at all (only for JSON / XML, see below)
`#array` | Expects actual value to be a JSON array
`#object` | Expects actual value to be a JSON object
`#boolean` | Expects actual value to be a boolean `true` or `false`
`#number` | Expects actual value to be a number
`#string` | Expects actual value to be a string
`#uuid` | Expects actual (string) value to conform to the UUID format
`#regex STR` | Expects actual (string) value to match the regular-expression 'STR' (see examples above)
`#? EXPR` | Expects the JavaScript expression 'EXPR' to evaluate to true, see [self-validation expressions](#self-validation-expressions) below
`#[NUM] EXPR` | Advanced array validation, see [schema validation](#schema-validation)
`#(EXPR)` | For completeness, [embedded expressions](#embedded-expressions) belong in this list as well
W
## Matching Sub-Sets of JSON Keys and Arrays
### `match contains`
#### JSON Keys
In some cases where the response JSON is wildly dynamic, you may want to only check for the existence of some keys. And `match` (name) `contains` is how you can do so:

```cucumber
* def foo = { bar: 1, baz: 'hello', ban: 'world' }

* match foo contains { bar: 1 }
* match foo contains { baz: 'hello' }
* match foo contains { bar:1, baz: 'hello' }
# this will fail
# * match foo == { bar:1, baz: 'hello' }
```

Note that `match contains` will "recurse", so any nested JSON chunks will also be matched using `match contains`:

```cucumber
* def original = { a: 1, b: 2, c: 3, d: { a: 1, b: 2 } }
* def expected = { a: 1, c: 3, d: { b: 2 } }
* match original contains expected
```

## Schema Validation
Karate provides a far more simpler and more powerful way than [JSON-schema](http://json-schema.org) to validate the structure of a given payload. You can even mix domain and conditional validations and perform all assertions in a single step.

But first, a special short-cut for array validation needs to be introduced:

```cucumber
* def foo = ['bar', 'baz']

# should be an array
* match foo == '#[]'

# should be an array of size 2
* match foo == '#[2]'

# should be an array of strings with size 2
* match foo == '#[2] #string'

# each array element should have a 'length' property with value 3
* match foo == '#[]? _.length == 3'

# should be an array of strings each of length 3
* match foo == '#[] #string? _.length == 3'

# should be null or an array of strings
* match foo == '##[] #string'
```

This 'in-line' short-cut for validating JSON arrays is similar to how [`match each`](#match-each) works. So now, complex payloads (that include arrays) can easily be validated in one step by combining [validation markers](#ignore-or-validate) like so:

```cucumber
* def oddSchema = { price: '#string', status: '#? _ < 3', ck: '##number', name: '#regex[0-9X]' }
* def isValidTime = read('time-validator.js')
When method get
Then match response ==
  """
  { 
    id: '#regex[0-9]+',
    count: '#number',
    odd: '#(oddSchema)',
    data: { 
      countryId: '#number', 
      countryName: '#string', 
      leagueName: '##string', 
      status: '#number? _ >= 0', 
      sportName: '#string',
      time: '#? isValidTime(_)'
    },
    odds: '#[] oddSchema'  
  }
  """
```

Especially note the re-use of the `oddSchema` both as an [embedded-expression](#embedded-expressions) and as an array validation (on the last line).

And you can perform conditional / [cross-field validations](#referring-to-the-json-root) and even business-logic validations at the same time.

```cucumber
# optional (can be null) and if present should be an array of size greater than zero
* match $.odds == '##[_ > 0]'

# should be an array of size equal to $.count
* match $.odds == '#[$.count]'

# use a predicate function to validate each array element
* def isValidOdd = function(o){ return o.name.length == 1 }
* match $.odds == '#[]? isValidOdd(_)'
```

Refer to this for the complete example: [`schema-like.feature`](karate-junit4/src/test/java/com/intuit/karate/junit4/demos/schema-like.feature)

And there is another example in the [karate-demos](karate-demo): [`schema.feature`](karate-demo/src/test/java/demo/schema/schema.feature) where you can compare Karate's approach with an actual JSON-schema example. You can also find a nice visual comparison and explanation [here](https://twitter.com/KarateDSL/status/878984854012022784).

# Special Variables
These are 'built-in' variables, there are only a few and all of them give you access to the HTTP response.

## `response`
After every HTTP call this variable is set with the response body, and is available until the next HTTP request over-writes it. You can easily assign the whole `response` (or just parts of it using Json-Path or XPath) to a variable, and use it in later steps.

The response is automatically available as a JSON, XML or String object depending on what the response contents are.

As a short-cut, when running JsonPath expressions - `$` represents the `response`.  This has the advantage that you can use pure [JsonPath](https://github.com/jayway/JsonPath#path-examples) and be more concise.  For example:

```cucumber
# the three lines below are equivalent
Then match response $ == { name: 'Billie' }
Then match response == { name: 'Billie' }
Then match $ == { name: 'Billie' }

# the three lines below are equivalent
Then match response.name == 'Billie'
Then match response $.name == 'Billie'
Then match $.name == 'Billie'

```
And similarly for XML and XPath, '/' represents the `response`
```cucumber
# the four lines below are equivalent
Then match response / == <cat><name>Billie</name></cat>
Then match response/ == <cat><name>Billie</name></cat>
Then match response == <cat><name>Billie</name></cat>
Then match / == <cat><name>Billie</name></cat> 

# the three lines below are equivalent
Then match response /cat/name == 'Billie'
Then match response/cat/name == 'Billie'
Then match /cat/name == 'Billie'
```

#### JsonPath short-cuts
The [`$varName` form](#get-short-cut) is used on the right-hand-side of [Karate expressions](#karate-expressions) and is *slightly* different from pure [JsonPath expressions](https://github.com/json-path/JsonPath#path-examples) which always begin with `$.` or `$[`. Here is a summary of what the different 'shapes' mean in Karate:

| Shape | Description |
| ----- | ----------- |
`$.bar` | Pure JsonPath equivalent of `$response.bar` where `response` is a JSON object
`$[0]`  | Pure JsonPath equivalent of `$response[0]` where `response` is a JSON array
`$foo.bar` | Evaluates the JsonPath `$.bar` on the variable `foo` which is a JSON object or map-like
`$foo[0]` | Evaluates the JsonPath `$[0]` on the variable `foo` which is a JSON array or list-like

> There is no need to prefix variable names with `$` on the left-hand-side of [`match`](#match) statements because it is implied. You *can* if you want to, but since [*only* JsonPath (on variables)](#match-and-variables) is allowed here, Karate ignores the `$` and looks only at the variable name. None of the examples in the documentation use the `$varName` form on the LHS, and this is the recommended best-practice.

## `responseStatus`
You would normally only need to use the [`status`](#status) keyword.  But if you really need to use the HTTP response code in an expression or save it for later, you can get it as an integer:

```cucumber
* def uploadStatusCode = responseStatus

# check if the response status is either of two values
Then assert responseStatus == 200 || responseStatus == 204
```

# Code Reuse / Common Routines
## `call`
In any complex testing endeavor, you would find yourself needing 'common' code that needs to be re-used across multiple test scripts. A typical need would be to perform a 'sign in', or create a fresh user as a pre-requisite for the scenarios being tested.

There are two types of code that can be `call`-ed. `*.feature` files and [JavaScript functions](#calling-javascript-functions).

## Calling other `*.feature` files
When you have a sequence of HTTP calls that need to be repeated for multiple test scripts, Karate allows you to treat a `*.feature` file as a re-usable unit. You can also pass parameters into the `*.feature` file being called, and extract variables out of the invocation result.

Here is an example of using the `call` keyword to invoke another feature file, loaded using the [`read`](#reading-files) function:

> If you find this hard to understand at first, try looking at this [set of examples](karate-demo/src/test/java/demo/callfeature/call-feature.feature).

```cucumber
Feature: which makes a 'call' to another re-usable feature

Background:
  * configure headers = read('classpath:my-headers.js')
  * def signIn = call read('classpath:my-signin.feature') { username: 'john', password: 'secret' }
  * def authToken = signIn.authToken

Scenario: some scenario
  # main test steps
```

> Note that [`def`](#def) can be used to *assign* a __feature__ to a variable. For example look at how "`creator`" has been defined in the `Background` in [this example](karate-demo/src/test/java/demo/calldynamic/call-dynamic-json.feature), and used later in a `call` statement. This is very close to how "custom keywords" work in other frameworks. See this other example for more ideas: [`dsl.feature`](karate-demo/src/test/java/demo/dsl/dsl.feature).

The contents of `my-signin.feature` are shown below. A few points to note:
* Karate creates a new 'context' for the feature file being invoked but passes along all variables and configuration. This means that all your [config variables](#configuration) and [`configure` settings](#configure) would be available to use, for example `loginUrlBase` in the example below. 
* When you use [`def`](#def) in the 'called' feature, it will **not** over-write variables in the 'calling' feature (unless you explicitly choose to use [shared scope](#shared-scope)). But note that JSON, XML, Map-like or List-like variables are 'passed by reference' which means that 'called' feature steps can *update* or 'mutate' them using the [`set`](#set) keyword. Use the [`copy`](#copy) keyword to 'clone' a JSON or XML payload if needed, and refer to this example for more details: [`copy-caller.feature`](karate-junit4/src/test/java/com/intuit/karate/junit4/demos/copy-caller.feature).
* You can add (or over-ride) variables by passing a call 'argument' as shown above. Only one JSON argument is allowed, but this does not limit you in any way as you can use any complex JSON structure. You can even initialize the JSON in a separate step and pass it by name, especially if it is complex. Observe how using JSON for parameter-passing makes things super-readable. In the 'called' feature, the argument can also be accessed using the built-in variable: [`__arg`](#built-in-variables-for-call).
* **All** variables that were defined (using [`def`](#def)) in the 'called' script would be returned as 'keys' within a JSON-like object. Note that this includes ['built-in' variables](#special-variables), which means that things like the last value of [`response`](#response) would also be present. In the example above you can see that the JSON 'envelope' returned - is assigned to the variable named `signIn`. And then getting hold of any data that was generated by the 'called' script is as simple as accessing it by name, for example `signIn.authToken` as shown above. This design has the following advantages:
  * 'called' Karate scripts don't need to use any special keywords to 'return' data and can behave like 'normal' Karate tests in 'stand-alone' mode if needed
  * the data 'return' mechanism is 'safe', there is no danger of the 'called' script over-writing any variables in the 'calling' (or parent) script (unless you use [shared scope](#shared-scope))
  * the need to explicitly 'unpack' variables by name from the returned 'envelope' keeps things readable and maintainable in the 'caller' script

> Note that only [variables](#def) and [configuration settings](#configure) will be passed. You can't do things such as `* url 'http://foo.bar'` and expect the URL to be set in the "called" feature. Use a variable in the "called" feature instead, for e.g. `* url myUrl`.

```cucumber
Feature: here are the contents of 'my-signin.feature'

Scenario:
  Given url loginUrlBase
  And request { userId: '#(username)', userPass: '#(password)' }
  When method post
  Then status 200
  And def authToken = response

  # second HTTP call, to get a list of 'projects'
  Given path 'users', authToken.userId, 'projects'
  When method get
  Then status 200
  # logic to 'choose' first project
  And set authToken.projectId = response.projects[0].projectId;
```

The above example actually makes two HTTP requests - the first is a standard 'sign-in' POST and then (for illustrative purposes) another HTTP call (a GET) is made for retrieving a list of projects for the signed-in user, and the first one is 'selected' and added to the returned 'auth token' JSON object.

So you get the picture, any kind of complicated 'sign-in' flow can be scripted and re-used.

> If the second HTTP call above expects headers to be set by `my-headers.js` - which in turn depends on the `authToken` variable being updated, you will need to duplicate the line `* configure headers = read('classpath:my-headers.js')` from the 'caller' feature here as well. The above example does **not** use [shared scope](#shared-scope), which means that the variables in the 'calling' (parent) feature are *not* shared by the 'called' `my-signin.feature`. The above example can be made more simpler with the use of `call` (or [`callonce`](#callonce)) *without* a [`def`](#def)-assignment to a variable, and is the [recommended pattern](#shared-scope) for implementing re-usable authentication setup flows.

Do look at the documentation and example for [`configure headers`](#configure-headers) also as it goes hand-in-hand with `call`. In the above example, the end-result of the `call` to `my-signin.feature` resulted in the `authToken` variable being initialized. Take a look at how the [`configure headers`](#configure-headers) example uses the `authToken` variable.

### Call Tag Selector
You can "select" a single `Scenario` (or `Scenario`-s or `Scenario Outline`-s or even specific `Examples` rows) by appending a "tag selector" at the end of the feature-file you are calling. For example:

```cucumber
call read('classpath:my-signin.feature@name=someScenarioName')
```

While the tag does not need to be in the `@key=value` form, it is recommended for readability when you start getting into the business of giving meaningful names to your `Scenario`-s.

This "tag selection" capability is designed for you to be able to "compose" flows out of existing test-suites when using the [Karate Gatling integration](karate-gatling). Normally we recommend that you keep your "re-usable" features lightweight - by limiting them to just one `Scenario`.

### Data-Driven Features
If the argument passed to the [call of a `*.feature` file](#calling-other-feature-files) is a JSON array, something interesting happens. The feature is invoked for each item in the array. Each array element is expected to be a JSON object, and for each object - the behavior will be as described above.

But this time, the return value from the `call` step will be a JSON array of the same size as the input array. And each element of the returned array will be the 'envelope' of variables that resulted from each iteration where the `*.feature` got invoked.

Here is an example that combines the [`table`](#table) keyword with calling a `*.feature`. Observe how the [`get`](#get) [shortcut](#get-short-cut) is used to 'distill' the result array of variable 'envelopes' into an array consisting only of [`response`](#response) payloads.

```cucumber
* table kittens 
  | name   | age |
  | 'Bob'  |   2 |
  | 'Wild' |   1 |
  | 'Nyan' |   3 |

* def result = call read('cat-create.feature') kittens
* def created = $result[*].response
* match each created == { id: '#number', name: '#string', age: '#number' }
* match created[*].name contains only ['Bob', 'Wild', 'Nyan']
```

And here is how `cat-create.feature` could look like:

```cucumber
@ignore
Feature:

Scenario:
  Given url someUrlFromConfig
  And path 'cats'
  And request { name: '#(name)', age: '#(age)' }
  When method post
  Then status 200
```

If you replace the `table` with perhaps a JavaScript function call that gets some JSON data from some data-source, you can imagine how you could go about dynamic data-driven testing.

Although it is just a few lines of code, take time to study the above example carefully. It is a great example of how to effectively use the unique combination of Cucumber and JsonPath that Karate provides.

Also look at the [demo examples](karate-demo), especially [`dynamic-params.feature`](karate-demo/src/test/java/demo/search/dynamic-params.feature) - to compare the above approach with how the Cucumber [`Scenario Outline:`](#the-cucumber-way) can be alternatively used for data-driven tests.

### Built-in variables for `call`
Although all properties in the passed JSON-like argument are 'unpacked' into the current scope as separate 'named' variables, it sometimes makes sense to access the whole argument and this can be done via `__arg`. And if being called in a loop, a built-in variable called `__loop` will also be available that will hold the value of the current loop index. So you can do things like this: `* def name = name + __loop` - or you can use the loop index value for looking up other values that may be in scope - in a data-driven style.

Variable  | Refers To
--------- | ------                               
| `__arg`   | the single `call` (or [`callonce`](#callonce)) argument, will be `null` if there was none         
| `__loop`  | the current iteration index (starts from 0) if being called in a loop, will be `-1` if not

Refer to this [demo feature](karate-demo) for an example: [`kitten-create.feature`](karate-demo/src/test/java/demo/calltable/kitten-create.feature)

### Default Values
Some users need "callable" features that are re-usable even when variables have not been defined by the calling feature. Normally an undefined variable results in nasty JavaScript errors. But there is an elegant way you can specify a default value using the [`karate.get()`](#karate-get) API:

```cucumber
# if foo is not defined, it will default to 42
* def foo = karate.get('foo', 42)
```

> A word of caution: we recommend that you should not over-use Karate's capability of being able to re-use features. Re-use can sometimes result in negative benefits - especially when applied to test-automation. Prefer readability over re-use. See this for an [example](https://stackoverflow.com/a/54126724/143475).

## Tags
Gherkin has a great way to sprinkle meta-data into test-scripts - which gives you some interesting options when running tests in bulk.  The most common use-case would be to partition your tests into 'smoke', 'regression' and the like - which enables being able to selectively execute a sub-set of tests.

The documentation on how to run tests via the [command line](#test-suites) has an example of how to use tags to decide which tests to *not* run (or ignore). Also see [`first.feature`](karate-demo/src/test/java/demo/tags/first.feature) and [`second.feature`](karate-demo/src/test/java/demo/tags/second.feature) in the [demos](karate-demo). If you find yourself juggling multiple tags with logical `AND` and `OR` complexity, refer to this [Stack Overflow answer](https://stackoverflow.com/a/34543352/143475) and this [blog post](https://testingneeds.wordpress.com/2015/09/15/junit-runner-with-cucumberoptions/).

> For advanced users, Karate supports being able to query for tags within a test, and even tags in a `@name=value` form. Refer to [`karate.tags`](#karate-tags) and [`karate.tagValues`](#karate-tagvalues).

### Tags And Examples
A little-known capability of the Cucumber / Gherkin syntax is to be able to tag even specific rows in a bunch of examples ! You have to repeat the `Examples` section for each tag. The example below combines this with the advanced features described above.

```cucumber
Scenario Outline: examples partitioned by tag
* def vals = karate.tagValues
* match vals.region[0] == expected

  @region=US
  Examples:
    | expected |
    | US       |

  @region=GB
  Examples:
    | expected |
    | GB       |
```

## Data Driven Tests
### The Cucumber Way
Cucumber has a concept of [Scenario Outlines](https://docs.cucumber.io/gherkin/reference/#scenario-outline) where you can re-use a set of data-driven steps and assertions, and the data can be declared in a very user-friendly fashion. Observe the usage of `Scenario Outline:` instead of `Scenario:`, and the new `Examples:` section.

You should take a minute to compare this with the [exact same example implemented in REST-assured and TestNG](https://github.com/basdijkstra/rest-assured-workshop/blob/d9734da98bfcd8087055bdcd78545581dd23cb77/src/test/java/answers/RestAssuredAnswers2Test.java). Note that this example only does a "string equals" check on *parts* of the JSON, but with Karate you are always encouraged to match the *entire* payload in one step.

```cucumber
Feature: karate answers 2

Background:
  * url 'http://localhost:8080'

Scenario Outline: given circuit name, validate country
  Given path 'api/f1/circuits/<name>.json'
  When method get
  Then match $.MRData.CircuitTable.Circuits[0].Location.country == '<country>'

  Examples:
    | name   | country  |
    | monza  | Italy    |
    | spa    | Belgium  |
    | sepang | Malaysia |

Scenario Outline: given race number, validate number of pitstops for Max Verstappen in 2015
  Given path 'api/f1/2015/<race>/drivers/max_verstappen/pitstops.json'
  When method get
  Then assert response.MRData.RaceTable.Races[0].PitStops.length == <stops>

  Examples:
    | race | stops |
    | 1    | 1     |
    | 2    | 3     |
    | 3    | 2     |
    | 4    | 2     |
```
This is great for testing boundary conditions against a single end-point, with the added bonus that your test becomes even more readable. This approach can certainly enable product-owners or domain-experts who are not programmer-folk, to review, and even collaborate on test-scenarios and scripts.

### Scenario Outline Enhancements
Karate has enhanced the Cucumber `Scenario Outline` as follows:
* __Type Hints__: if the `Examples` column header has a `!` appended, each value will be evaluated as a JavaScript data-type (number, boolean, or *even* in-line JSON) - else it defaults to string.
* __Magic Variables__: `__row` gives you the entire row as a JSON object, and `__num` gives you the row index (the first row is `0`).
* __Auto Variables__: in addition to `__row`, each column key-value will be available as a separate [variable](#def), which greatly simplifies JSON manipulation - especially when you want to re-use JSON [files](#reading-files) containing [embedded expressions](#embedded-expressions).
  * You can disable the "auto variables" behavior by setting the `outlineVariablesAuto` [`configure` setting](#configure) to `false`.
* Any empty cells will result in a `null` value for that column-key

These are best explained with [examples](karate-junit4/src/test/java/com/intuit/karate/junit4/demos/outline.feature). You can choose between the string-placeholder style `<foo>` or *directly* refer to the [variable](#def) `foo` (or even the *whole row* JSON as `__row`) in JSON-friendly [expressions](#karate-expressions).

Note that even the scenario name can accept placeholders - which is very useful in reports. 

```cucumber
Scenario Outline: name is <name> and age is <age>
  * def temp = '<name>'
  * match temp == name
  * match temp == __row.name
  * def expected = __num == 0 ? 'name is Bob and age is 5' : 'name is Nyan and age is 6'
  * match expected == karate.info.scenarioName

  Examples:
    | name | age |
    | Bob  | 5   |
    | Nyan | 6   |

Scenario Outline: magic variables with type hints
  * def expected = [{ name: 'Bob', age: 5 }, { name: 'Nyan', age: 6 }]
  * match __row == expected[__num]

  Examples:
    | name | age! |
    | Bob  | 5    |
    | Nyan | 6    |

Scenario Outline: embedded expressions and type hints
  * match __row == { name: '#(name)', alive: '#boolean' }

  Examples:
    | name | alive! |
    | Bob  | false  |
    | Nyan | true   |

Scenario Outline: inline json
  * match __row == { first: 'hello', second: { a: 1 } }
  * match first == 'hello'
  * match second == { a: 1 }

  Examples:
    | first  | second!  |
    | hello  | { a: 1 } |
```

For another example, see: [`examples.feature`](karate-demo/src/test/java/demo/outline/examples.feature).

### The Karate Way
The limitation of the Cucumber `Scenario Outline:` (seen above) is that the number of rows in the `Examples:` is fixed. But take a look at how Karate can [loop over a `*.feature` file](#data-driven-features) for each object in a JSON array - which gives you dynamic data-driven testing, if you need it. For advanced examples, refer to some of the scenarios within this [demo](karate-demo): [`dynamic-params.feature`](karate-demo/src/test/java/demo/search/dynamic-params.feature#L70).

Also see the option below, where you can data-drive an `Examples:` table using JSON.

### Dynamic Scenario Outline
You can feed an `Examples` table from a JSON array, which is great for those situations where the table-content is dynamically resolved at run-time. This capability is triggered when the table consists of a single "cell", i.e. there is exactly one row and one column in the table.  Here is an example (also see [this video](https://twitter.com/KarateDSL/status/1051433711814627329)):

```cucumber
Feature: scenario outline using a dynamic table

Background:
    * def kittens = read('../callarray/kittens.json')

Scenario Outline: cat name: <name>
    Given url demoBaseUrl
    And path 'cats'
    And request { name: '<name>' }
    When method post
    Then status 200
    And match response == { id: '#number', name: '<name>' }

    # the single cell can be any valid karate expression
    # and even reference a variable defined in the Background
    Examples:
    | kittens |
```

The great thing about this approach is that you can set-up the JSON array using the `Background` section. Any [Karate expression](#karate-expressions) can be used in the "cell expression", and you can even use [Java-interop](#calling-java) to use external data-sources such as a database. Note that Karate has built-in support for [CSV files](#csv-files) and here is an example: [`dynamic-csv.feature`](karate-demo/src/test/java/demo/outline/dynamic-csv.feature).
