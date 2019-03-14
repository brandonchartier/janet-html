(def void-elements
  [:area :base :br :col :embed
   :hr :img :input :keygen :link
   :meta :param :source :track :wbr])

(defn void-element?
  [name]
  (some (partial = name) void-elements))

(defn text-element?
  [name]
  (= name :text))

(defn attr-reducer
  [acc [attr value]]
  (string acc " " attr "=\"" value "\""))

(defn create-attrs
  [attrs]
  (reduce attr-reducer "" (pairs attrs)))

(defn opening-tag
  [name attrs]
  (string "<" name (create-attrs attrs) ">"))

(defn closing-tag
  [name]
  (string "</" name ">"))

(defn first-child
  [children]
  (if (indexed? children)
      (first children)
      children))

(defn create-children
  [create children]

  (defn child-reducer
    [acc child]
    (string acc (create child)))

  (let [child (first-child children)]
    (cond (indexed? child)
          (reduce child-reducer "" children)
          (keyword? child)
          (create children)
          :else children)))

(defn valid-children?
  [children]
  (or (indexed? children)
      (number? children)
      (string? children)))

(defn validate-element
  [name attrs children]
  (unless (keyword? name)
          (error "name must be a keyword"))
  (unless (dictionary? attrs)
          (error "attributes must be a dictionary"))
  (unless (valid-children? children)
          (error "children must be a string, number, or index")))

(defn create-element
  [create name attrs children]
  (validate-element name attrs children)
  (cond (void-element? name)
        (opening-tag name attrs)
        (text-element? name)
        (string children)
        :else
        (string (opening-tag name attrs)
                (create-children create children)
                (closing-tag name))))

(defn create
  [element]
  (case (length element)
    1 (let [[name] element]
        (create-element create name {} ""))
    2 (let [[name param] element]
        (if (dictionary? param)
            (create-element create name param "")
            (create-element create name {} param)))
    3 (let [[name attrs children] element]
        (create-element create name attrs children))))

(defn img
  [src &opt alt attrs]
  (default alt "")
  (default attrs {})
  [:img (merge attrs {:src src :alt alt})])

(defn link
  [url &opt content attrs]
  (default content url)
  (default attrs {})
  [:a (merge attrs {:href url}) content])

(defn mail
  [email &opt content attrs]
  (default content email)
  (default attrs {})
  [:a (merge attrs {:href (string "mailto:" email)}) content])

(defn ol
  [list]
  [:ol (map (fn [x] [:li x]) list)])

(defn ul
  [list]
  [:ul (map (fn [x] [:li x]) list)])
