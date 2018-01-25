//
//  Curry.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public func fcurry<A, B, C>(_ function: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { (a: A) -> (B) -> C in
        { (b: B) -> C in
            function(a, b)
        }
    }
}

public func funcurry<A, B, C>(_ function: @escaping (A) -> (B) -> C) -> (A ,B) -> C {
    return { (a: A, b: B) -> C in
        function(a)(b)
    }
}

public func fcurry<A, B, C, D>(_ function: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
    return { (a: A) -> (B) -> (C) -> D in
        { (b: B) -> (C) -> D in
            { (c: C) -> D in
                function(a, b, c)
            }
        }
    }
}

public func funcurry<A, B, C, D>(_ function: @escaping (A) -> (B) -> (C) -> D) -> (A, B, C) -> D {
    return { (a: A, b: B, c: C) -> D in
        function(a)(b)(c)
    }
}

public func fcurry<A, B, C, D, E>(_ function: @escaping (A, B, C, D) -> E) -> (A) -> (B) -> (C) -> (D) -> E {
    return { (a: A) -> (B) -> (C) -> (D) -> E in
        { (b: B) -> (C) -> (D) -> E in
            { (c: C) -> (D) -> E in
                { (d: D) -> E in
                    function(a, b, c, d)
                }
            }
        }
    }
}

public func funcurry<A, B, C, D, E>(_ function: @escaping (A) -> (B) -> (C) -> (D) -> E) -> (A, B, C, D) -> E {
    return { (a: A, b: B, c: C, d: D) -> E in
        function(a)(b)(c)(d)
    }
}

public func fcurry<A, B, C, D, E, F>(_ function: @escaping (A, B, C, D, E) -> F) -> (A) -> (B) -> (C) -> (D) -> (E) -> F {
    return { (a: A) -> (B) -> (C) -> (D) -> (E) -> F in
        { (b: B) -> (C) -> (D) -> (E) -> F in
            { (c: C) -> (D) -> (E) -> F in
                { (d: D) -> (E) -> F in
                    { (e: E) -> F in
                        function(a, b, c, d, e)
                    }
                }
            }
        }
    }
}


public func funcurry<A, B, C, D, E, F>(_ function: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> F) -> (A, B, C, D, E) -> F {
    return { (a: A, b: B, c: C, d: D, e: E) -> F in
        function(a)(b)(c)(d)(e)
    }
}

public func fcurry<A, B, C, D, E, F, G>(_ function: @escaping (A, B, C, D, E, F) -> G) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> G {
    return { (a: A) -> (B) -> (C) -> (D) -> (E) -> (F) -> G in
        { (b: B) -> (C) -> (D) -> (E) -> (F) -> G in
            { (c: C) -> (D) -> (E) -> (F) -> G in
                { (d: D) -> (E) -> (F) -> G in
                    { (e: E) -> (F) -> G in
                        { (f: F) -> G in
                            function(a, b, c, d, e, f)
                        }
                    }
                }
            }
        }
    }
}

public func funcurry<A, B, C, D, E, F, G>(_ function: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> G) -> (A, B, C, D, E, F) -> G {
    return { (a: A, b: B, c: C, d: D, e: E, f: F) -> G in
        function(a)(b)(c)(d)(e)(f)
    }
}

public func fcurry<A, B, C, D, E, F, G, H>(_ function: @escaping (A, B, C, D, E, F, G) -> H) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> H {
    return { (a: A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> H in
        { (b: B) -> (C) -> (D) -> (E) -> (F) -> (G) -> H in
            { (c: C) -> (D) -> (E) -> (F) -> (G) -> H in
                { (d: D) -> (E) -> (F) -> (G) -> H in
                    { (e: E) -> (F) -> (G) -> H in
                        { (f: F) -> (G) -> H in
                            { (g: G) -> H in
                                function(a, b, c, d, e, f, g)
                            }
                        }
                    }
                }
            }
        }
    }
}

public func funcurry<A, B, C, D, E, F, G, H>(_ function: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> H) -> (A, B, C, D, E, F, G) -> H {
    return { (a: A, b: B, c: C, d: D, e: E, f: F, g: G) -> H in
        function(a)(b)(c)(d)(e)(f)(g)
    }
}

public func fcurry<A, B, C, D, E, F, G, H, I>(_ function: @escaping (A, B, C, D, E, F, G, H) -> I) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> (H) -> I {
    return { (a: A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> (H) -> I in
        { (b: B) -> (C) -> (D) -> (E) -> (F) -> (G) -> (H) -> I in
            { (c: C) -> (D) -> (E) -> (F) -> (G) -> (H) -> I in
                { (d: D) -> (E) -> (F) -> (G) -> (H) -> I in
                    { (e: E) -> (F) -> (G) -> (H) -> I in
                        { (f: F) -> (G) -> (H) -> I in
                            { (g: G) -> (H) -> I in
                                { (h: H) -> I in
                                    function(a, b, c, d, e, f, g, h)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

public func funcurry<A, B, C, D, E, F, G, H, I>(_ function: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> (H) -> I) -> (A, B, C, D, E, F, G, H) -> I {
    return { (a: A, b: B, c: C, d: D, e: E, f: F, g: G, h: H) -> I in
        function(a)(b)(c)(d)(e)(f)(g)(h)
    }
}

public func fcurry<A, B, C, D, E, F, G, H, I, J>(_ function: @escaping (A, B, C, D, E, F, G, H, I) -> J) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> (H) -> (I) -> J {
    return { (a: A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> (H) -> (I) -> J in
        { (b: B) -> (C) -> (D) -> (E) -> (F) -> (G) -> (H) -> (I) -> J in
            { (c: C) -> (D) -> (E) -> (F) -> (G) -> (H) -> (I) -> J in
                { (d: D) -> (E) -> (F) -> (G) -> (H) -> (I) -> J in
                    { (e: E) -> (F) -> (G) -> (H) -> (I) -> J in
                        { (f: F) -> (G) -> (H) -> (I) -> J in
                            { (g: G) -> (H) -> (I) -> J in
                                { (h: H) -> (I) -> J in
                                    { (i: I) -> J in
                                        function(a, b, c, d, e, f, g, h, i)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

public func funcurry<A, B, C, D, E, F, G, H, I, J>(_ function: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> (H) -> (I) -> J) -> (A, B, C, D, E, F, G, H, I) -> J {
    return { (a: A, b: B, c: C, d: D, e: E, f: F, g: G, h: H, i: I) -> J in
        function(a)(b)(c)(d)(e)(f)(g)(h)(i)
    }
}
