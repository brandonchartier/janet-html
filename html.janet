(import helpers :as h)

(def empty-elements
  [:area :base :br :col :embed
   :hr :img :input :keygen :link
   :meta :param :source :track :wbr])

(defn empty-element?
  [name]
  (some (partial = name) empty-elements))

(defn append-attr
  [acc [attr value]]
  (string acc " " attr "=\"" value "\""))

(defn create-attributes
  [attrs]
  (if (dictionary? attrs)
      (reduce append-attr "" (pairs attrs))
      ""))

(defn opening-tag
  [name params]
  (let [attrs (create-attributes params)]
    (string "<" name attrs ">")))

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

  (defn append-child
    [acc child]
    (string acc (create child)))

  (let [child (first-child children)]
    (cond (keyword? child)
          (create children)
          (indexed? child)
          (reduce append-child "" children)
          :else child)))

(defn children-as-params?
  [params children]
  (and (nil? children)
       (or (indexed? params)
           (number? params)
           (bytes? params))))

(defn normalize-element
  [[name params children]]
  (cond (children-as-params? params children)
        [name {} params]
        (h/all-nil? params children)
        [name {} ""]
        (h/first-nil? params children)
        [name {} children]
        (h/first-nil? children params)
        [name params ""]
        :else
        [name params children]))

(defn text-node-with-children?
  [params children]
  (and (string? params)
       (indexed? children)))

(defn create
  [element]
  (let [[name params children] (normalize-element element)
        body (opening-tag name params)]
    (cond (empty-element? name)
          body
          (text-node-with-children? params children)
          (string body
                  params
                  (create-children create children)
                  (closing-tag name))
          :else
          (string body
                  (create-children create children)
                  (closing-tag name)))))
