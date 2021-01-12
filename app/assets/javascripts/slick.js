$(document).on('turbolinks:load', function() {
  $('.slider').not('.slick-initialized').slick({
    autoplay: true,
    autoplaySpeed: 3500,
    dots: true,
    centerMode: true,
    slidesToShow: 5,
    centerPadding: '20%',
    variableWidth: true,
  })
});
