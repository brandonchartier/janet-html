# html

```
(import html :as h)

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

(print (h/create [:div (todos-view todo-data)]))

(print (h/create [:img {:src "/dog.gif"}]))
(print (h/create (h/img "/dog.gif")))

(print (h/create [:br]))
(print (h/create [:p "Lorem ipsum"]))

(print (h/create [:a {:href "http://github.com"} "GitHub"]))
(print (h/create (h/link "http://github.com" "GitHub")))

(print (h/create [:span [[:text "Hello "] [:em "world!"]]]))
```
