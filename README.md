# html

```
(import html)

(def todos
  [{:id 1 :text "foo"}
   {:id 2 :text "bar"}
   {:id 3 :text "baz"}])

(defn todo-fmt
  [todo]
  [[:span (get todo :id)]
   [:span (get todo :text)]])

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
(print (html/create [:p {:custom-attr "custom value"}]))
(print (html/create [:a {:href "http://github.com"} "GitHub"]))
```
