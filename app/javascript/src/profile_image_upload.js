$(document).on("change", "#plan_image_upload", function(e) {
  if (e.target.files.length) {
    let reader = new FileReader;
    reader.onload = function(e) {
      $('.hidden').removeClass();
      $('.img').hide();
      $('.plan-default-img').removeClass();
      $('#plan-img').remove();
      $('#plan-img-prev').attr('src', e.target.result);
    };
    return reader.readAsDataURL(e.target.files[0]);
  }
});
