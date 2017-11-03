/************************************
    File Name: custom.js
    Template Name: TruvaTour
    Created By: Similar Icons
    Envato Profile: http://themeforest.net/user/similaricons
    Website: https://similaricons.com
    Version: 1.0
************************************/

(function($) {
    "use strict";

    /* ==============================================
    WINDOW HEIGHT -->
    =============================================== */

    $(".js-height-full").height($(window).height());
        $(".js-height-parent").each(function(){
        $(this).height($(this).parent().first().height());
    });

    /* ==============================================
    OWL CAROUSEL -->
    =============================================== */

        $('.owl-car-widget').owlCarousel({
            loop:false,
            nav:false,
            dots:true,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                1000:{
                    items:1
                }
            }
        })

        $('.owl-car-widget-rating').owlCarousel({
            loop:false,
            nav:false,
            dots:true,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                1000:{
                    items:1
                }
            }
        })

        $('#owl-full').owlCarousel({
            loop:false,
            nav:false,
            dots:true,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                1000:{
                    items:2
                }
            }
        })

        $('.owl-tours').owlCarousel({
            loop:true,
            margin:30,
            nav:true,
            dots:false,
            navText: [
               "<i class='fa fa-angle-left'></i>",
               "<i class='fa fa-angle-right'></i>"
            ],
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:2
                },
                1080:{
                    items:2
                },
                1180:{
                    items:3
                }
            }
        })

        $('.owl-hotels').owlCarousel({
            loop:true,
            margin:30,
            nav:true,
            dots:false,
            navText: [
               "<i class='fa fa-angle-left'></i>",
               "<i class='fa fa-angle-right'></i>"
            ],
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:2
                },
                1080:{
                    items:2
                },
                1180:{
                    items:3
                }
            }
        })

        $('#owl-tours').owlCarousel({
            loop:true,
            margin:30,
            nav:true,
            dots:false,
            navText: [
               "<i class='fa fa-angle-left'></i>",
 
              "<i class='fa fa-angle-right'></i>"
            ],
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:2
                },
                1080:{
                    items:3
                },
                1180:{
                    items:3
                }
            }
        })

        $('#owl-testimonials').owlCarousel({
            loop:true,
            margin:30,
            nav:true,
            dots:false,
            navText: [
               "<i class='fa fa-angle-left'></i>",
 
              "<i class='fa fa-angle-right'></i>"
            ],
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                1080:{
                    items:1
                },
                1180:{
                    items:1
                }
            }
        })

    /* ==============================================
    HOVER SUB MENU -->
    =============================================== */

    $('.has-submenu .dropdown-menu [data-toggle=dropdown]').on('click', function(event) {
        event.preventDefault(); 
        event.stopPropagation(); 
        $(this).parent().addClass('open');
        $(this).parent().find("ul").parent().find("li.dropdown").addClass('open');
    });

    /* ==============================================
    PRELOADER -->
    =============================================== */

    $(window).load(function() {
        $("#preloader").on(500).fadeOut();
        $(".preloader").on(600).fadeOut("slow");
    });

    /* ==============================================
    TOOLTIP -->
    =============================================== */

        $('[data-toggle="tooltip"]').tooltip()

    /* ==============================================
    AFFIX -->
    =============================================== */

        $('.header').affix({offset: {top: 150} }); 
        $('.fixmymap').affix({offset: {top: 150} }); 

    /* ==============================================
    STAT COUNT -->
    =============================================== */
    
        function count($this) {
            var current = parseInt($this.html(), 10);
            current = current + 1; /* Where 50 is increment */
            $this.html(++current);
            if (current > $this.data('count')) {
                $this.html($this.data('count'));
            } else {
                setTimeout(function() {
                    count($this)
                }, 50);
            }
        }
        $(".stat_count").each(function() {
            $(this).data('count', parseInt($(this).html(), 10));
            $(this).html('0');
            count($(this));
        });

    /* ==============================================
    SMOOTH SCROLL -->
    =============================================== */

    $(function() {
      $('a.scrollit[href*="#"]:not([href="#"])').on(function() {
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
          var target = $(this.hash);
          target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
          if (target.length) {
            $('html, body').animate({
              scrollTop: target.offset().top
            }, 1000);
            return false;
          }
        }
      });
    });

})(jQuery);