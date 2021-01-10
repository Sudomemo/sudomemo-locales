![](https://github.com/sudomemo/sudomemo-locales/blob/images/Sudomemo_Locales_Github_Card.png)
For public contributions to localization efforts on Sudomemo.

Full and verified translations can earn you the special Translator Trophy on Sudomemo!

Please note that translations will be verified; contributions will not be accepted if you only use Google Translate or if things are translated in an inappropriate manner.

## How to contribute during a Roundup

Translation Roundups are events where we work to get everything that's not translated brought up to date. Please check the list of [issues](https://github.com/Sudomemo/sudomemo-locales/issues) to see if we have an active Roundup going on. If so, please read the instructions there for special information.

Some things that are different during Roundups:

- We will only be accepting complete translations, and they need to submitted in a **single Pull Request**. We suggest working on a single branch on your fork, but if you've created multiple branches, make sure to merge them into a single branch before submitting your PR.
- A list of untranslated strings for your language can be found in the Issues list. If there are things that should not be translated, please list the `msgid`s in the details of your Pull Request so that we can add it to our ignore list.
- Further details, including "claiming" a language for translation, can be found by reviewing the instructions for the Roundup.

## How to contribute

Before starting work on a new language or updating an existing one, please check for existing Pull Requests for your language. If you submit a duplicate/incomplete one and somebody else has already done the work, your PR may be closed.

1. If you don't already have a GitHub account, please [sign up](https://github.com/join) for one.

2. Take a look at our repository, in which you will see a few folders for different langcodes, like `en_US` and `ja_JP`. If you don't see a folder with the langcode for your chosen language, then skip to step 3. If you aren't sure what the langcode is, [a full list is available here](http://www.lingoes.net/en/translator/langcode.htm)

3. If the langcode for your language isn't there, [open a new issue](https://github.com/Sudomemo/sudomemo-locales/issues/new) and request that we add it.

4. Once we add the language, fork this repository by clicking the **Fork** button. This will create a copy of it on your own GitHub account.

5. Open your forked copy of sudomemo-locales, and then open the **LC_MESSAGES** folder for your chosen language. You should see a lot of files that end with **.po** -- these are the translation files!

7. For each **.po** file, translate any lines that start with **`msgstr`**. 

	* If the text starts with an `@` symbol, you can remove the `@` symbol. 
	* Sometimes, format characters like `%s` and `%d` are used as placeholders (for example, the `%s` in "Flipnote by %s" becomes a username), please make sure these go in the right places!
    
8. When you're ready to to submit your changes to us, go to the Pull Requests tab and click on **New Pull Request**

9. Give your Pull Request a title and add your Flipnote Studio ID in the comment area along with anything you want to note.

	* Your summary should explain what you changed; "added German translation" or "fixed Japanese translation for blockSettings.po" are examples of good summaries.


10. We'll review your Pull Request as soon as possible, make sure to check back regularly in case there is something we ask you to fix.

### Ignore Lists

Sometimes there's strings that shouldn't be translated. Those get added to our ignore list.

For example, youtube.po for ja_JP has some strings that don't get translated. We put the msgid's in this file:

`/ignores/ja_JP/youtube.txt`

This is used for our tool that finds untranslated strings.


#### Example Langcode list

Common languages:

| Name    | Language          |
|:--------|:------------------|
| `en_US` | American English  |
| `fr_FR` | French  |
| `de_DE` | German  |
| `nl_NL` | Dutch  |
| `es_ES` | Spanish  |
| `pt_PT` | Portugese |
| `nl_NL` | Dutch  |
| `it_IT` | Italian  |
| `ja_JP` | Japanese  |

[A full list is available here](http://www.lingoes.net/en/translator/langcode.htm)

If you have any question about which langcode to use, feel free to reach out to us on Discord (via SudoModMail) or on Twitter (`@sudomemo`).

## Thank You

We'd like to thank each and every one of the people helping make Sudomemo more open to people of all backgrounds. You can [view a list of contributors here](https://github.com/Sudomemo/sudomemo-locales/graphs/contributors).
