# fetch_google_images

The scripts aim to fetch html pages responsed by google when using images or keywords to get related or same images.

###
Usage:

* Before running codes, you should replace some arguments. 
	* `http_proxy=[your_proxy]`
		* If you can access google directly, then delete it. If not, using an available proxy to replace it
	* `--user-agent="[your_user_agent]"`
		* Use user agent in your browser. Like this:

				Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36

* sh fetch\_google\_same\_images.sh [_images url and prefix file_] \[_target directory of html files_]
	* format of images url and prefix file, **tab** as separator:
		
			url_1,prefix_1
			url_2,prefix_2
			...

* sh fetch\_google\_search\_images.sh [_keywords and prefix file_] \[_target directory of html files_]
	* format of keywords and prefix file, **tab** as separator:

    		keyword_1,prefix_1
    		keyword_2,prefix_2
    		...
