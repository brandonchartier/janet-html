(def- empty-elements
  [:area :base :br :col :embed
   :hr :img :input :keygen :link
   :meta :param :source :track :wbr])

(defn- empty-element?
  [name]
  (some (partial = name) empty-elements))

(defn- append-attr
  [acc [attr value]]
  (string acc " " attr "=\"" value "\""))

(defn- opening-tag
  [name params]
  (def attrs (reduce append-attr "" (pairs params)))
  (string "<" name attrs ">"))

(defn- closing-tag
  [name]
  (string "</" name ">"))

(defn- first-child
  [children]
  (if (indexed? children)
      (first children)
      children))

(defn- create-children
  [create children]

  (defn- append-child
    [acc child]
    (string acc (create child)))

  (let [child (first-child children)]
    (cond (keyword? child)
          (create children)
          (indexed? child)
          (reduce append-child "" children)
          :default child)))

(defn- children-as-params?
  [params children]
  (and (nil? children)
       (or (indexed? params)
           (number? params)
           (bytes? params))))

(defn- both-nil?
  [a b]
  (and (nil? a)
       (nil? b)))

(defn- first-nil?
  [a b]
  (and (nil? a)
       (not (nil? b))))

(defn- normalize-args
  [[name params children]]
  (cond (children-as-params? params children)
        [name {} params]
        (both-nil? params children)
        [name {} ""]
        (first-nil? params children)
        [name {} children]
        (first-nil? children params)
        [name params ""]
        :default
        [name params children]))

(defn create
  [element]
  (let [[name params children] (normalize-args element)
        body (opening-tag name params)]
        (if (empty-element? name)
            body
            (string body
                    (create-children create children)
                    (closing-tag name)))))
