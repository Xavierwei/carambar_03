<div class="form">
  
  <?php echo CHtml::beginForm("/user/loginform")?>
    
  <?php echo CHTml::errorSummary($model)?>
  
  <div class="row">
    <?php echo CHtml::activeLabel($model, "company_email")?>
    <?php echo CHtml::activeEmailField($model, "company_email")?>
  </div>
  
  <div class="row">
    <?php echo CHtmL::activeLabel($model, "password")?>
    <?php echo CHtml::activePasswordField($model, "password")?>
  </div>
    
  <div class="row submit">
    <?php echo CHtml::submitButton("Login")?>
  </div>
  
  <?php echo CHtml::endForm()?>
</div>