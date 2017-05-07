<?php

use yii\helpers\Url;
use yii\widgets\DetailView;
$request = Yii::$app->request;
$this->title = 'Stream Play';
$this->params['breadcrumbs'][]=['label'=>'IPTV Monitor', 'url'=>['index']];
$this->params['breadcrumbs'][] = ['label' => 'Streams Monitor', 'url' => ['streams-monitor', 'serverName'=>$request->get('serverName')]];
$this->params['breadcrumbs'][] = $this->title;
?>
<?php
    echo DetailView::widget([
        'model' => $model,
        'template' => function ($attribute, $index, $widget){
        if($index%2 == 0){
            return '<tr class="label-white"><th>' . $attribute['label'] . '</th><td>' . $attribute['value'] . '</td></tr>';
        }else{
            return '<tr class="label-grey"><th>' . $attribute['label'] . '</th><td>' . $attribute['value'] . '</td></tr>';
        }
        },
        'attributes' => [
            'streamName',
            [
                'label' => 'server',
                'format' => 'html',
                'value' => '<a href="'.Url::to(['monitor/server-detail', 'serverName'=>$request->get('serverName')]).
                '">'.$model->server.'</a>',
            ],
            [
                'label' => 'Status',
                'format' => 'html',
                'value' => $model->status == 1 ? '<i class="fa fa-circle" style="color:#5cb85c;"></i>' : '<i class="fa fa-circle" style="color:#d9534f;"></i>'
            ],
            [
                'label' => 'Source Status',
                'format' => 'html',
                'value' => $model->sourceStatus == 1 ? '<i class="fa fa-circle" style="color:#5cb85c;"></i>' : '<i class="fa fa-circle" style="color:#d9534f;"></i>'
            ],
        ],
    ]);
    echo \wbraganca\videojs\VideoJsWidget::widget([
        'options' => [
            'class' => 'video-js vjs-default-skin',
            'controls' => true,
            'preload' => 'auto',
            'width' => '1000',
            'height' => '540',
            'data' => [
                'setup' => [
                    'autoplay' => true,
                ],
                
            ],
        ],
        'tags' => [
            'source' => [
                ['src' => $url, 'type' => 'application/x-mpegURL']
            ]
        ]
    ]);
?>