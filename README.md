# sudomemo-locales
For public contributions to localization efforts on Sudomemo.

Full and verified translations can earn you citizenship on Sudomemo! c:

Please note that translations will be verified; contributions will not be accepted if you only use Google Translate or if things are translated in an inappropriate manner.

## How to contribute

1. If you don't already have a GitHub account, please [sign up](https://github.com/join) for one.

2. Fork this repository by clicking the **Fork** button. This will create a copy of it on your own GitHub account.

3. Now we need to clone your newly Forked repository to your PC so that you can work on it. You'll need to download the official [GitHub Desktop app](https://desktop.github.com/) for this.

4. Once you've downloaded and opened GitHub Desktop, go to **File** > **Clone Repository**.

	* Copy and paste the GitHub URL for your Fork into the **URL or username/repository** area.

	* For the **local path**, choose a convenient folder on your PC.

5. Navigate to the repository's folder (hint: with GitHub Desktop you can do this by going to **Repository** > **Show In Explorer**).

6. In here, you should see a few folders for different langcodes, like `en_US` and `ja_JP`. If you don't see a folder with the langcode for your chosen language, then please make a copy of `en_US` and rename it. If you aren't sure what the langcode is, we have a list [here](#langcode-list)

7. Open the folder for your chosen language, and then open the **LC_MESSAGES** folder. You should see a lot of files that end with **.po** -- these are the translation files!

8. To make changes to a translation file, open it in a text editor. Something like Notepad is fine, but if you're not sure about what to use, we recommend [Atom](https://atom.io/).

9. Using a text editor, translate any **.po** lines that start with **`msgstr`**. 
	* If the text starts with an `@` symbol, you can remove the `@` symbol. 
    * Sometimes, format characters like `%s` and `%d` are used as placeholders (for example, the `%s` in "Flipnote by %s" becomes a username), please make sure these go in the right places!
    
10. After you've made changes, go back to **GitHub Desktop**. You should see all the files you've changed under the **Changes** tab. Below, there should be an input box where you can enter a **Summary** and **Description**.

	* Your summary should explain what you changed; "added German translation" or "fixed Japanese translation for blockSettings.po" are examples of good summaries.

	* Decription is optional, so don't worry about it.

11. Click the **Commit to master** button at the bottom. Your changes will now be saved to GitHub. You may continue to make changes in the same way until you're ready to submit them back to us.

12. When you're ready to to submit your changes to us, go to **Github Desktop** and choose **Branch** > **Create Pull Request**

13. Give your Pull Request a title and add your Flipnote Studio ID in the comment area along with anything you want to note. Finally, click on **Create Pull Request** to submit it. 

14. We'll review your Pull Request as soon as possible, make sure to check back regularly in case there is something we ask you to fix. c:

#### Langcode list

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

If you have any question about which langcode to use, feel free to reach out to us on Discord (`@sudofox#8048` or `@jaames#7359`) or on Twitter (`@sudomemo` or `@rakujira`).

## Thank You

#### English to Japanese

@[Bukharin1](https://www.twitter.com/Fin_suomi_)
@[Compeito](https://twitter.com/ugo_compeito)
@[SlawomirNowak](https://twitter.com/Starbros_s)
@[ManatoProject](https://github.com/ManatoProject)

#### English to Greek 

@[igantzia](https://github.com/igantzia)

#### English to Dutch

@[olafher](https://github.com/olafher)

#### English to Spanish

@[NaoVolkova](https://github.com/NaoVolkova)
