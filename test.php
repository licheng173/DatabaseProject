<!DOCTYPE html>
<html>
<body>

<form action="sendRecipeTest.php" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label for="photos">Photo(s)</label>
        <div class="input_photos_wrap" id="photos">
            <div><input type="file" id="photo" name="photo"></div>
        </div>
        <button class="add_photo_button btn btn-primary">Add More Photos
        </button>
        <button type="submit" class="btn btn-primary">Submit</button>
    </div>
</form>

</body>
</html>