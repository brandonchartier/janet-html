# html

```
(import html)

(def todos
  [{:id 1 :text "foo"}
   {:id 2 :text "bar"}
   {:id 3 :text "baz"}])

(defn todo-fmt
  [todo]
  [[:span (todo :id)]
   [:span (todo :text)]])

(defn todo-view
  [todo]
  [:li (todo-fmt todo)])

(defn todos-view
  [todos]
  [:ul {:id "foo" :class "bar"}
    (map todo-view todos)])

(print (html/create [:div (todos-view todos)]))
(print (html/create [:img {:src "/dog.gif"}]))
(print (html/create [:br]))
(print (html/create [:p "Lorem ipsum"]))
(print (html/create [:a {:href "http://github.com"} "GitHub"]))
(print (html/create [:span "Hello " [:em "world!"]]))
```
