(import ../html :as h)

(def todo-data
  [{:id 1 :value "foo"}
   {:id 2 :value "bar"}
   {:id 3 :value "baz"}])

(defn todo-fmt
  [todo]
  [[:text (todo :id)]
   [:strong (todo :value)]])

(defn todo-view
  [todo]
  [:li (todo-fmt todo)])

(defn todos-view
  [data]
  [:ul {:id "foo" :class "bar"}
   (map todo-view data)])

(assert (deep= (h/create [:div (todos-view todo-data)])
               "<div><ul class=\"bar\" id=\"foo\"><li>1<strong>foo</strong></li><li>2<strong>bar</strong></li><li>3<strong>baz</strong></li></ul></div>"))

(assert (deep= (h/create [:img {:src "/dog.gif"}])
               "<img src=\"/dog.gif\">"))

(assert (deep= (h/create (h/img "/dog.gif"))
               "<img src=\"/dog.gif\" alt=\"\">"))

(assert (deep= (h/create [:br])
               "<br>"))

(assert (deep= (h/create [:p "Lorem ipsum"])
               "<p>Lorem ipsum</p>"))

(assert (deep= (h/create [:a {:href "http://github.com"} "GitHub"])
               "<a href=\"http://github.com\">GitHub</a>"))

(assert (deep= (h/create (h/link "http://github.com" "GitHub"))
               "<a href=\"http://github.com\">GitHub</a>"))

(assert (deep= (h/create [:span [[:text "Hello "] [:em "world!"]]])
               "<span>Hello <em>world!</em></span>"))
