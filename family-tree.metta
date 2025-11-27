; Gender Atoms
(Male Chernet)
(Male Ermyas)
(Male Muluken)
(Male Temesgen)
(Male Haileleul)
(Male Biniam)
(Male Ayalkibet)

(Male Erdachew)
(Male Tadele)
(Male Mame)
(Male Amare)
(Male Haile)

(Male Yirgu)
(Male Biruk)

(Male Amen)
(Male Dagm)
(Male Kaleb)

(Female Mekdes)
(Female Beza)
(Female Samrawit)
(Female Lili)

(Female Weynua)
(Female Genet)
(Female Demekech)
(Female Blen)

(Female Emebet)


;parent Atoms
(Parent Erdachew Chernet)
(Parent Maye Chernet)
(Female Maye)
(Parent Erdachew Mekdes)
(Parent Erdachew Ermyas)

(Parent Tadele Muluken)
(Parent Genet Muluken)
(Parent Genet Beza)

(Parent Demekech Temesgen)
(Parent Demekech Samrawit)

(Parent Amare Haileleul)
(Parent Amare Biniam)

(Parent Haile Ayalkibet)
(Parent Haile Lili)

(Parent Yirgu Weynua)
(Parent Yirgu Erdachew)
(Parent Selam Erdachew)
(Female Selam)
(Parent Yirgu Tadele)

(Parent Emebet Genet)
(Parent Emebet Demekech)
(Parent Emebet Mame)

(Parent Biruk Blen)
(Parent Biruk Amare)
(Parent Biruk Haile)

(Parent Amen Yirgu)
(Parent Dagm Emebet)
(Parent Dagm Biruk)

(Parent Kaleb Amen)
(Parent Kaleb Dagm)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Brother Function  ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;identity function / returning itself
(=(get-x $X) $X)
;brother of X function
(= (get-brother $x)
   (match &self
     (, (Parent $z $x)
        (Parent $z $y)
        (Male $y))
     $y
   )
)
;substract self from brothers becuase get-brother returns self as well
(=(get-brothers $X) (subtraction(unique (get-brother $X)) (get-x $X)))
; ! (get-brothers Chernet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;  Sister Function  ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sister of X function
(= (get-sister $x)
   (match &self
     (, (Parent $y $x)
        (Parent $y $z)
        (Female $z))
     $z
   )
)
;substract self from sisters becuase get-sister returns self as well
(=(get-sisters $X) (subtraction (unique(get-sister $X)) (get-x $X)))
; ! (get-sisters Chernet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;  Siblings Function ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;get siblings function
(=(get-siblings $X) (union (get-brothers $X) (get-sisters $X)) )
; ! (get-siblings Chernet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Father Function  ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;get father
(= (get-father $x)
   (match &self
     (, (Parent $z $x)
        (Male $z))
     $z
   )
)
; ! (get-father Chernet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Mother Function  ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;get mother
(= (get-mother $x)
   (match &self
     (, (Parent $z $x)
        (Female $z))
     $z
   )
)
; ! (get-mother Chernet)
;parents - either father or mother
(=(get-parents $X) (union (get-father $X) (get-mother $X)) )
; !(get-parents Chernet)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Uncle Function  ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;uncle
(=(get-uncle $X)
    (match &self 
        (, (Parent $Y $X)
            (Parent $Z $Y)
            (Parent $Z $U)
            (Male $U)
            )
        $U
    )
)
;substract parent from uncle
(=(get-uncles $X) (subtraction (unique(get-uncle $X)) (get-parents $X)) )
; ! (get-uncles Chernet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Aunt Function  ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;aunt
(=(get-aunt $X)
    (match &self 
        (, (Parent $Y $X)
            (Parent $Z $Y)
            (Parent $Z $U)
            (Female $U)
            )
        $U
    )
)
;substract parent from aunt
(=(get-aunts $X) (subtraction(unique (get-aunt $X)) (get-parents $X)) )
; ! (get-aunts Chernet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Cousin Function  ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;cousin
(=(get-cousin $X)
    (match &self 
        (, (Parent $Y $X)
            (Parent $Z $Y)
            (Parent $Z $U)
            (Parent $U $C)
            )
        $C
    )
)
;get unique cousins
(=(get-cousins $X) (subtraction(unique (get-cousin $X)) (union (union (get-brothers $X) (get-sisters $X) ) (get-x $X))) )
; !(get-cousins Chernet)   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Grandparent Function  ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;get grandparent
(= (get-grandparent $X)
   (match &self
     (, (Parent $Y $X)
        (Parent $Z $Y))
     $Z
   )
)
; ! (get-grandparent Chernet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Children Function ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;get children
(= (get-child $X)
   (match &self
     (Parent $X $Y)
     $Y
   )
)
;unique children
(=(get-children $X) (unique (get-child $X)) )
; ! (get-children Yirgu)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Son Function  ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;get son
(= (get-son $X)
   (match &self
     (, (Parent $X $Y)
        (Male   $Y))
     $Y
   )
)
;unique son
(=(get-sons $X) (unique (get-son $X)) )
; ! (get-sons Erdachew)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Daughter Function  ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;get daughter
(= (get-daughter $X)
   (match &self
     (, (Parent $X $Y)
        (Female $Y))
     $Y
   )
)
;unique daughter
(=(get-daughters $X) (unique (get-daughter $X)) )
; ! (get-daughters Erdachew)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Grandchild Function  ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;get grandchild
(= (get-grandchild $X)
   (match &self
     (, (Parent $Y $Z)
        (Parent $X $Y))
     $Z
   )
)
; ! (get-grandchild Kaleb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   grand-father Function  ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(= (get-grand-father $X)
   (match &self
     (, (Parent $Y $X)
        (Parent $Z $Y)
        (Male $Z))
     $Z
   )
)
; ! (get-grand-father Chernet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   grand-mother Function  ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    

(= (get-grand-mother $X)
   (match &self
     (, (Parent $Y $X)
        (Parent $Z $Y)
        (Female $Z))
     $Z
   )
)
; ! (get-grand-mother Chernet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   female-child Function  ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;get female child of self
(= (get-female-child $X)
   (match &self
     (, (Parent $X $Y)
        (Female $Y))   
        $Y
    )
)
;unique female child
(=(get-female-children $X) (unique (get-female-child $X)) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; male-child Function  ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;get male child of self
(= (get-male-child $X)
   (match &self
     (, (Parent $X $Y)
        (Male $Y))  
        $Y
    )
)
;unique male child
(=(get-male-children $X) (unique (get-male-child $X)) )
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Niece Function  ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;nice
(=(get-niece $X)
    (match &self 
        (, (Parent $Y $X)
            (Parent $Y $Z)
            (Parent $Z $U)
            (Female $U)
            )
        $U
    )
)
;sabtract female self child from nice
(=(get-nieces $X) (subtraction (unique(get-niece $X)) (get-female-children $X)) )
; ! (get-nieces Genet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Nephew Function  ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;nephew
(=(get-nephew $X)
    (match &self 
        (, (Parent $Y $X)
            (Parent $Y $Z)
            (Parent $Z $U)
            (Male $U)
            )   
        $U
    )
)
;unique nephew
(=(get-nephews $X) (subtraction (unique(get-nephew $X)) (get-male-children $X)) )
; ! (get-nephews Haile)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Husband Function ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;husband
(= (get-husband $Z)
   (match &self
     (, (Parent $X $Y)
        (Male $X)
        (Parent $Z $Y)
        (Female $Z))
     $X
   )
)
; ! (get-husband Maye)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Wife Function ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;wife
(= (get-wife $Z)
   (match &self
     (, (Parent $X $Y)
        (Female $X)
        (Parent $Z $Y)
        (Male $Z))
     $X
   )
)
; ! (get-wife Erdachew)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;   Ethnic Percentage  ;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(Ethnicity Yirgu Amhara 0.3)
(Ethnicity Yirgu Oromo 0.5)
(Ethnicity Selam Amhara 0.6)
(Ethnicity Selam Oromo 0.4)

(Ethnicity Maye Oromo 0.2)
(Ethnicity Maye Amhara 0.3)
(Ethnicity Maye Gamo 0.5)

(Ethnicity Emebet Amhara 0.6)
(Ethnicity Emebet Oromo 0.2)
(Ethnicity Emebet Gamo 0.1)

(Ethnicity Biruk Amhara 0.4)
(Ethnicity Biruk Oromo 0.5)
(Ethnicity Biruk Gamo 0.1)
    
;get percentage from mother
(= (get-ethnic-percentage-mother $child $ethnicity)
    (match &self
        (, 
            (Parent $mother $child)
            (Female $mother)
        )
        (let $results (collapse (match &self (Ethnicity $mother $ethnicity $q) $q))
            (if (== $results ())
                0                       
                (superpose $results)    
            )
        )
    )
)

;get percentage from father
(= (get-ethnic-percentage-father $child $ethnicity)
    (match &self
        (, (Parent $father $child) (Male $father))
        (let $results (collapse (match &self (Ethnicity $father $ethnicity $q) $q))
            (if (== $results ())
                0                       
                (superpose $results)   
            )
        )
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Ethnicity recursive Function  ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(= (get-ethnicity $person $ethnicity)
   (let $direct (collapse (match &self (Ethnicity $person $ethnicity $val) $val))
      (if (== $direct ())
          (calc-from-parents $person $ethnicity) 
          (superpose $direct)
      )
   )
)

; the contribution from Mother (Female) and Father (Male)
(= (calc-from-parents $child $ethnicity)
   (+ 
      (get-parent-contribution $child $ethnicity Female)
      (get-parent-contribution $child $ethnicity Male)
   )
)


(= (get-parent-contribution $child $ethnicity $gender-predicate)
   (let $parents (collapse (match &self 
                            (, 
                               (Parent $p $child) 
                               ($gender-predicate $p)
                            ) 
                            $p))
      (if (== $parents ())
          0   
          (/ (get-ethnicity (superpose $parents) $ethnicity) 2)
      )
   )
)

; ! (get-ethnicity Chernet Oromo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Find Familiy R/n Fun ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;self and sibling
(= (get-relation $X $Y) (match &self (, (Parent $Z $X)(Parent $Z $Y)) ( if(== $X $Y ) (the same person) ($X is sibling of $Y)) ))
;brother
(= (get-relation $X $Y) (match &self (, (Parent $Z $X)(Parent $Z $Y) (Male $Y))( if(== $X $Y ) (the same person) ($Y is brother of $X))))
(= (get-relation $Y $X) (match &self (, (Parent $Z $X)(Parent $Z $Y) (Male $Y))( if(== $X $Y ) (the same person) ($Y is brother of $X))))
;sister
(= (get-relation $X $Y) (match &self (, (Parent $Z $X)(Parent $Z $Y) (Female $Y)) ($Y is sister of $X)))
(= (get-relation $Y $X) (match &self (, (Parent $Z $X)(Parent $Z $Y) (Female $Y)) ($Y is sister of $X)))
;father and child
(= (get-relation $X $Y) (match &self (, (Parent $X $Y)(Male $X)) ($X is father of $Y)))
(= (get-relation $X $Y) (match &self (, (Parent $Y $X)(Male $Y)) ($Y is father of $X)))

;mother and child
(= (get-relation $X $Y) (match &self (, (Parent $X $Y)(Female $X)) ($X is mother of $Y)))
(= (get-relation $X $Y) (match &self (, (Parent $Y $X)(Female $Y)) ($Y is mother of $X)))

;uncle 
(= (get-relation $Y $X) 
   (match &self 
      (, 
         (Parent $Z $X)  
         (Parent $K $Z)   
         (Parent $K $Y)   
         (Male $Y)        
      ) 
      (if (not (== $Y $Z))
          ($Y is uncle of $X) 
          (superpose ())     
      )
   )
)
(= (get-relation $X $Y) 
   (match &self 
      (, 
         (Parent $Z $X)  
         (Parent $K $Z)   
         (Parent $K $Y)   
         (Male $Y)        
      ) 
      (if (not (== $Y $Z))
          ($Y is uncle of $X) 
          (superpose ())     
      )
   )
)
; (= (get-relation $X $Y) (subtraction(match &self (, (Parent $Z $X)(Parent $K $Z)(Parent $K $Y)(Male $Y)) ($Y is uncle of $X)) (match &self (Parent $Y $X) ($Y is uncle of $X)))) 
; (= (get-relation $Y $X) (match &self (, (Parent $Z $X)(Parent $K $Z)(Parent $K $Y)(Male $Y)) ($Y is uncle of $X)))

;aunt
(= (get-relation $X $Y) (match &self (, (Parent $Z $X)(Parent $K $Z)(Parent $K $Y)(Female $Y)) ($Y is aunt of $X)))
(= (get-relation $Y $X) (match &self (, (Parent $Z $X)(Parent $K $Z)(Parent $K $Y)(Female $Y)) ($Y is aunt of $X)))
!(get-relation Weynua Chernet)

;nephew
(= (get-relation $X $Y) (match &self (, (Parent $Z $X)(Parent $K $Z)(Parent $K $Y) (Male $X))  ($X is nephew of $Y)))
(= (get-relation $Y $X) (match &self (, (Parent $Z $X)(Parent $K $Z)(Parent $K $Y) (Male $X))  ($X is nephew of $Y)))
;niece
(= (get-relation $X $Y) (match &self (, (Parent $Z $X)(Parent $K $Z)(Parent $K $Y) (Female $X))  ($X is niece of $Y)))
(= (get-relation $Y $X) (match &self (, (Parent $Z $X)(Parent $K $Z)(Parent $K $Y) (Female $X))  ($X is niece of $Y)))
;grandparent
(= (get-relation $X $Y) (match &self (, (Parent $Z $X)(Parent $Y $Z)(Male $Y)) ($Y is grand father of $X)))
(= (get-relation $Y $X) (match &self (, (Parent $Z $X)(Parent $Y $Z)(Male $Y)) ($Y is grand father of $X)))

(= (get-relation $X $Y) (match &self (, (Parent $Z $X)(Parent $Y $Z)(Female $Y)) ($Y is grand mother of $X)))
(= (get-relation $Y $X) (match &self (, (Parent $Z $X)(Parent $Y $Z)(Female $Y)) ($Y is grand mother of $X)))
;unique
(= (get-relations $X $Y) (unique(get-relation $X $Y)) ) 
!(get-relations Ermyas Chernet)
