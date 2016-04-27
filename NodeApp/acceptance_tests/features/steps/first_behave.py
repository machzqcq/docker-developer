from behave import *

use_step_matcher("re")


@given("I have two integers a and b")
def step_impl(context):
    context.a = 1
    context.b = 2


@when("I add the numbers")
def step_impl(context):
    context.sum = int(context.a) + int(context.b)


@then("I print the addition result")
def step_impl(context):
    print("Sum of", context.a, "and", context.b, "is:",context.sum)

@given(u'I open the home page')
def step_impl(context):
    context.browser.get("http://localhost:3000")

@then(u'I verify the title and body are what I expect')
def step_impl(context):
    print(context.browser.title)
    assert 'Express' in context.browser.title

